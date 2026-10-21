#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Windows-1254/ISO-8859-9 dosyalarini UTF-8'e donusturur.
Turkce karakterleri korur.

Kullanim:
    python convert_to_utf8.py <dosya_yolu>           # Tek dosya
    python convert_to_utf8.py <klasor_yolu> --all    # Tum txt dosyalari
"""

import os
import sys
import shutil
from datetime import datetime

def detect_encoding(filepath):
    """Dosyanin encoding'ini tespit et"""
    with open(filepath, 'rb') as f:
        raw = f.read()
    
    # UTF-8 BOM kontrolu
    if raw.startswith(b'\xef\xbb\xbf'):
        return 'utf-8-sig'
    
    # UTF-8 olarak decode etmeyi dene
    try:
        raw.decode('utf-8')
        return 'utf-8'
    except UnicodeDecodeError:
        pass
    
    # ISO-8859-9 (Turkce) veya Windows-1254
    return 'iso-8859-9'

def convert_file(filepath, backup=True):
    """Dosyayi UTF-8'e donustur"""
    
    # Encoding tespit et
    encoding = detect_encoding(filepath)
    
    if encoding in ('utf-8', 'utf-8-sig'):
        print(f"[SKIP] {os.path.basename(filepath)} - Zaten UTF-8")
        return False
    
    # Dosyayi oku
    with open(filepath, 'rb') as f:
        raw = f.read()
    
    # Decode et
    try:
        text = raw.decode(encoding)
    except UnicodeDecodeError as e:
        print(f"[HATA] {os.path.basename(filepath)} - Decode hatasi: {e}")
        return False
    
    # Yedek al
    if backup:
        backup_path = filepath + '.bak'
        if not os.path.exists(backup_path):
            shutil.copy2(filepath, backup_path)
    
    # UTF-8 olarak kaydet (BOM olmadan)
    with open(filepath, 'w', encoding='utf-8', newline='') as f:
        f.write(text)
    
    print(f"[OK] {os.path.basename(filepath)} - {encoding} -> UTF-8")
    return True

def convert_directory(dirpath, extensions=('.txt',)):
    """Klasordeki tum dosyalari donustur"""
    converted = 0
    skipped = 0
    errors = 0
    
    for root, dirs, files in os.walk(dirpath):
        # Alt klasorleri atla (sadece belirtilen klasor)
        dirs.clear()
        
        for filename in files:
            if any(filename.lower().endswith(ext) for ext in extensions):
                filepath = os.path.join(root, filename)
                try:
                    if convert_file(filepath):
                        converted += 1
                    else:
                        skipped += 1
                except Exception as e:
                    print(f"[HATA] {filename}: {e}")
                    errors += 1
    
    print(f"\nOzet: {converted} donusturuldu, {skipped} atlandi, {errors} hata")
    return converted, skipped, errors

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    
    path = sys.argv[1]
    
    if os.path.isfile(path):
        convert_file(path)
    elif os.path.isdir(path):
        if '--all' in sys.argv:
            convert_directory(path)
        else:
            print(f"Klasor icin --all parametresi gerekli:")
            print(f"  python convert_to_utf8.py \"{path}\" --all")
    else:
        print(f"Dosya veya klasor bulunamadi: {path}")
        sys.exit(1)

if __name__ == '__main__':
    main()
