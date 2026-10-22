import app
import grp
import wndMgr
import ui
import os
import sys
import stat
import chrmgr
import chr
import net
import background
import snd
import net
import player
import localeInfo
import uiScriptLocale

class Console(object):
	def __init__(self, output):
		self.dirNameList = []
		self.fileNameList = []

		self.output = output
		self.curPathName = "D:\\Ymir Work\\"
		self.collision = 0

		self.bgPartDict = {
			"terrain":background.PART_TERRAIN,
			"object":background.PART_OBJECT,
			"cloud":background.PART_CLOUD,
			"tree":background.PART_TREE,
			"water":background.PART_WATER,
			"sky":background.PART_SKY,
		}

		self.bgSortDict = {
			"distance":background.DISTANCE_SORT,
			"texture":background.TEXTURE_SORT,
		}

		self.game = 0

	def Close(self):
		self.output = 0

	def BindGameClass(self, game):
		self.game = game

	def Exit(self):
		"Programdan Çık"
		app.Exit()

	def EnablePerformanceTime(self, mode, isEnable):
		app.EnablePerformanceTime(mode, int(isEnable))

	def ReloadLocale(self):
		"Locale Yeniden Yükle"
		reload(localeInfo)
		reload(uiScriptLocale)
		self.Print("LOCALE YENİDEN YÜKLE")

	def ReloadDevel(self):
		"ReloadDevel"
		import consoleModule
		import uiGuild
		import uiInventory
		reload(uiGuild)
		self.Print("ReloadGuild")
		reload(uiInventory)
		self.Print("ReloadInventory")

	def ShowPerformanceInfo(self):
		"Performans Bilgisi Gösterir"
		self.Print(app.GetInfo(app.INFO_ACTOR))
		self.Print(app.GetInfo(app.INFO_ITEM))
		self.Print(app.GetInfo(app.INFO_EFFECT))
		self.Print(app.GetInfo(app.INFO_TEXTTAIL))

	def Disconnect(self):
		"Bilinmeyen paket göndererek bağlantıyı kes"
		net.SendStrangePacket()

	def ToggleActorDirectionLine(self):
		"Karakterin yön çizgisini gösterir"
		chrmgr.ToggleDirectionLine()

	def RegisterCharacterEffect(self, effectType, effectFileName):
		"Karakterin efekt durumunu ayarla (durum no, kemik adı, efekt dosyası/no)"
		if effectFileName.isdigit():
			effectFileName = self.GetFileName(int(effectFileName))

		effectFullPathFileName = self.GetFullPathName(effectFileName)
		chrmgr.RegisterEffect(chrmgr.EFFECT_STATE+int(effectType), "", effectFullPathFileName)
		self.Print("efekt durumu %d: %s" % (int(effectType), effectFullPathFileName))

	def SetCharacterAffect(self, affectType, isVisible):
		"Karakterin etkisini ayarla (numara, görünürlük 1|0)"
		chrmgr.SetAffect(-1, int(affectType), int(isVisible))
		self.Print("etki ayarla %d: %d" % (int(affectType), int(isVisible)))

	def SetCharacterEmoticon(self, EmoticonNum):
		"İfade göster (numara)"
		chrmgr.SetEmoticon(-1, int(EmoticonNum))
		self.Print("İfade %d" % int(EmoticonNum))

	def ShowPickedCharacterInfo(self):
		"Seçili karakterin bilgisini göster"
		vid=chrmgr.GetPickedVID()
		info=chrmgr.GetVIDInfo(vid)
		self.Print(info)

	def ShowCharacterInfo(self, arg):
		"Karakter bilgisini göster (vid)"
		if arg.isdigit():
			vid=int(arg)
		else:
			vid=0

		info=chrmgr.GetVIDInfo(vid)
		self.Print(info)

	def SetWeaponTraceTexture(self, arg):
		"Kılıç art görüntü dokusu ayarlar (dosya adı)"
		if arg.isdigit():
			textureFileName = self.GetFileName(int(arg))
		else:
			textureFileName = arg

		chr.WeaponTraceSetTexture(textureFileName)

	def SetAutoCameraRotationSpeed(self, arg):
		"Otomatik kamera dönüş hızı (açı/sn)"
		spd=float(arg)
		player.SetAutoCameraRotationSpeed(spd)

		self.Print("Otomatik kamera dönüş hızı: %f" % (spd))

	def SetWeaponTraceMode(self, *mode):
		"Kılıç art görüntü modu (0 = Alfa kullan, 1 = Doku kullan)"
		if mode and mode[0].isdigit() and int(mode[0]):
			chr.WeaponTraceUseTexture()
		else:
			chr.WeaponTraceUseAlpha()

	def SetCollision(self, *mode):
		"Çarpışma nesnelerini göster (0 | 1)"
		if mode and mode[0].isdigit():
			self.collision = int(mode[0])
		else:
			self.collision = not self.collision

	def SetMovingSpeed(self, arg):
		"Yürüme hızını ayarla"
		chrmgr.SetMovingSpeed(int(arg))

	def SetMusicVolume(self, arg):
		"Set BGM volumn (0 ~ 1.0)"
		snd.SetMusicVolume(float(arg))

	def SetSoundVolume(self, arg):
		"Efekt ses düzeyini ayarla (0 ~ 5)"
		snd.SetSoundVolume(int(arg))

	def SetSoundScale(self, arg):
		"3D Sound scale (default : 200)"
		snd.SetSoundScale(int(arg))

	def SetAmbienceSoundScale(self, arg):
		"3D Ortam sesi ölçeği (varsayılan : 200)"
		snd.SetAmbienceSoundScale(int(arg))

	def SetCoolTime(self):
		"Bekleme süresi değiştir"
		flag = player.ToggleCoolTime()
		if flag:
			self.Print("Bekleme süresi uygulanacak")
		else:
			self.Print("Bekleme süresi devre dışı")

	def SetLevelLimit(self):
		"Seviye sınırı ayarlar"
		flag = player.ToggleLevelLimit()
		if flag:
			self.Print("Seviye sınırı uygulanacak")
		else:
			self.Print("Seviye sınırı devre dışı")

	def ShowCursor(self):
		app.ShowCursor()

	def HideCursor(self):
		app.HideCursor()

	def Print(self, msg):
		self.output.Print(msg)

	def RefreshPath(self):
		self.SetPath(self.curPathName)

	def	SetPath(self, newPathName):
		if '\\'!=newPathName[-1]:
			newPathName=newPathName+'\\'

		if os.access(newPathName, os.R_OK)==0:
			self.Print(newPathName+"Yol bulunamıyor")
			return

		nameList=os.listdir(newPathName)

		dirNameList=[]
		fileNameList=[]
		for sName in nameList:
			mode=os.stat(newPathName+sName)[stat.ST_MODE]
			if stat.S_ISDIR(mode):
				dirNameList.append(sName)
			else:
				fileNameList.append(sName)

		self.curPathName=newPathName
		self.dirNameList=dirNameList
		self.fileNameList=fileNameList

		self.ShowPath()

	def GetPath(self):
		return self.curPathName

	def GetDirName(self, iDir):
		if (len(self.dirNameList)>iDir):
			return self.dirNameList[iDir]
		else:
			print len(self.dirNameList)
			return ""

	def GetFileName(self, iFile):
		if (len(self.fileNameList)>iFile):
			return self.fileNameList[iFile]
		else:
			print len(self.fileNameList)
			return ""

	def	MoveParentPath(self):
		"Üst dizine git"
		newPathName=self.GetPath()

		lastPos=-1
		if '\\'==newPathName[-1]:
			lastPos=-2

		lastPos=newPathName.rfind('\\', 0,	lastPos)
		if 0>lastPos:
			self.Print("Kök dizin burası")
			return

		newPathName=newPathName[0:lastPos]+'\\'

		self.SetPath(newPathName)

	def GetFullPathName(self, sPathName):
		sParentPathName=self.GetPath()

		if '\\'!=sParentPathName[-1]:
			sParentPathName=sParentPathName+'\\'

		return sParentPathName+sPathName

	def	MoveChildPath(self, directory):
		"[Dizin adı/numarası] alt dizine geç"
		if ""==directory:
			self.Print("Dizin adı veya numarası gerekli")
			return

		if directory.isdigit():
			directory=self.GetDirName(int(directory))

		newPathName=self.GetFullPathName(directory)

		self.SetPath(newPathName)

	def SetHitEffect(self, arg):
		"Vuruş efekti ayarlar"
		if arg.isdigit():
			effectFileName = self.GetFileName(int(arg))
		else:
			effectFileName = arg

		effectFullPathFileName=self.GetFullPathName(effectFileName)
		chrmgr.RegisterEffect(chrmgr.EFFECT_HIT, "", effectFullPathFileName)

		self.Print("Vuruş efekti:"+effectFullPathFileName)

	def SetStunEffect(self, arg):
		"Sersemletme efekti ayarlar"
		if arg.isdigit():
			effectFileName = self.GetFileName(int(arg))
		else:
			effectFileName = arg

		effectFullPathFileName = self.GetFullPathName(effectFileName)
		chrmgr.RegisterEffect(chrmgr.EFFECT_STUN, "Bip01 Kafa", effectFullPathFileName)

		self.Print("Sersemletme efekti:"+effectFullPathFileName)

	def SetDustEffect(self, arg):
		"Kir efekti ayarlar"
		if arg.isdigit():
			effectFileName = self.GetFileName(int(arg))
		else:
			effectFileName = arg

		effectFullPathFileName = self.GetFullPathName(effectFileName)
		chrmgr.RegisterEffect(chrmgr.EFFECT_DUST, "", effectFullPathFileName)

		self.Print("Kir efekti:"+effectFullPathFileName)

	def SetDustGap(self, arg):
		"Kir efekti aralığı ayarlar"
		if arg.isdigit() == 0:
			self.Print("Kir efekti aralık argümanı sayı olmalı")
		else:
			gap = int(arg)
			chrmgr.SetDustGap(gap)
			self.Print("Kir efekti aralığı: %d" % (gap))

	def ShowBackgroundPart(self, arg):
		"Arka plan parçasını göster"
		try:
			background.SetVisiblePart(self.bgPartDict[arg], 1);
		except KeyError:
			self.Print("Bilinmeyen parça:", arg);
		except:
			raise

	def HideBackgroundPart(self, arg):
		"Arka plan parçasını gizle"
		try:
			background.SetVisiblePart(self.bgPartDict[arg], 0);
		except KeyError:
			self.Print("Bilinmeyen parça:", arg);
		except:
			raise

	def SetShadowLevel(self, arg):
		"Gölge seviyesi ayarı (0~5)"
		if arg.isdigit() == 0:
			self.Print("Gölge ayarı sayı olmalı")
		else:
			level = int(arg)

			if level < 0 or level > 5:
				self.Print("Gölge seviyesi aralığı 0~5")
			else:
				background.SetShadowLevel(level)
				self.Print("Gölge seviyesi: %d" % (level))

	def SetSplatLimit(self, arg):
		"Splat sayı limiti"
		if arg.isdigit() == 0:
			self.Print("Splat sayı limiti sayı olmalı")
		else:
			limit = int(arg)

			background.SetSplatLimit(limit)
			self.Print("Splat sayı limiti: %d" % (limit))

	def SelectViewDistanceNum(self, arg):
		"View distance (0~4)"
		if arg.isdigit() == 0:
			self.Print("0 ile 4 arasında girin")
		else:
			settingnum = int(arg)

			if settingnum < 0 or settingnum > 4:
				self.Print("Görüş mesafesi aralığı 0 ile 4 arası")

			else:
				background.SelectViewDistanceNum(settingnum)
				self.Print("Görüş mesafesi: %d" % (settingnum))

	def SetBGLoading(self, bBGLoading):
		"Arka plan yükleme (0, 1)"
		bResultBoolean = int(bBGLoading)

		if bResultBoolean != 0 and bResultBoolean != 1:
			self.Print("0 veya 1 girin")
		else:
			background.SetBGLoading(bResultBoolean)
			self.Print("Arka plan yükleme: %d" % (bResultBoolean))

	def SetTerrainRenderSort(self, arg):
		"Arazi render tipi"
		try:
			background.SetRenderSort(self.bgSortDict[arg]);
		except KeyError:
			self.Print("Bilinmeyen parça:", arg);
		except:
			raise

	def SetTransparentTree(self, arg):
		"Ağacın yaprak şeffaflığı"
		bTransparent = int(arg)
		try:
			background.SetTransparentTree(bTransparent);
		except KeyError:
			self.Print("0 veya 1 olmalı:", bTransparent);
		except:
			raise

	def WarpTest(self, warpX, warpY):
		"WarpTest : warp dwX dwY"
		iWarpX = int(warpX)
		iWarpY = int(warpY)
		try:
			background.Destroy()
			background.Initialize()
			background.WarpTest(iWarpX, iWarpY);
			background.RegisterEnvironmentData(0, "d:/ymir work/environment/b3.msenv")
			background.SetEnvironmentData(0)
			background.SetShadowLevel(background.SHADOW_ALL)
		except:
			import exception
			exception.Abort("consoleModule.Console.WarpTest")

	def ToggleDebugInfo(self):
		"DebugInfo Göster"
		net.ToggleGameDebugInfo()

	def ShowPath(self):
		"Şu anki yolu göster"
		self.Print("Şu anki yol"+self.GetPath())

	def	ShowList(self):
		"Şu anki yolun listesini göster"
		self.ShowDirList()
		self.ShowFileList()

	def	ShowDirList(self):
		"Şu anki yolun alt dizinlerini göster"
		self.Print(self.GetPath()+" directories:")
		self.ShowNameList(self.dirNameList)
		self.Print("")

	def	ShowFileList(self, Filter=[]):
		"Şu anki yolun dosyalarını göster (uzantı filtresi)"
		self.Print(self.GetPath()+" files:")
		self.ShowNameList(self.fileNameList, Filter)
		self.Print("")

	def	ShowEffectList(self):
		"Şu anki yolun efektlerini göster"
		self.Print(self.GetPath()+" effects:")
		self.ShowNameList(self.fileNameList, ["mse"])
		self.Print("")

	def ShowWeb(self):
		"ShowWeb"
		if app.IsWebPageMode():
			app.HideWebPage()
		else:
			app.ShowWebPage("http://wiki.metin.co.kr/metin1help/01.htm", (0, 0, 320, 600))

	def ShowUI(self):
		"Arayüzü gösterir"
		self.game.CheckGameButton()
		self.game.interface.ShowDefaultWindows()
		self.game.interface.wndChat.Show()

	def HideUI(self):
		"Arayüzü gizler"
		self.game.interface.HideAllWindows()
		self.game.interface.wndChat.Hide()

	def SetCameraSpeed(self, percentage):
		"Kamera hızı ayarlar (Varsayılan = 100)"
		app.SetCameraSpeed(int(percentage))

	def SaveCameraSetting(self, filename):
		"Şu anki kamera özelliklerini kaydet (dosya adı)"
		app.SaveCameraSetting(filename)

	def LoadCameraSetting(self, filename):
		"Kamera özelliklerini yükle (dosya adı)"
		if not app.LoadCameraSetting(filename):
			self.Print("Kamera özelliği yüklenemedi")

	def SetDefaultCamera(self):
		"Varsayılan kamera özelliğine dön"
		app.SetDefaultCamera()

	def ShowClock(self, second):
		self.game.ShowClock(int(second))

	def HideClock(self):
		self.game.HideClock()

	def ShowNotice(self):
		app.SetVisibleNotice(True)
		self.Print("Duyuruyu Göster")

	def HideNotice(self):
		app.SetVisibleNotice(False)
		self.Print("Duyuruyu Gizle")

	def SetSight(self, range):
		"Görüş Mesafesini Zorla Ayarla"
		app.SetSightRange(int(range))

	def SetComboType(self, type):
		chr.testSetComboType(int(type))

	def SetSkillGroupFake(self, index):
		net.SetSkillGroupFake(int(index))
		self.Print("SetSkillGroupFake : %d" % int(index))

	def SetEmpireLanguageMode(self, mode):
		net.SetEmpireLanguageMode(int(mode))
		self.Print("SetEmpireLanguageMode : %d" % int(mode))

	def SetCharacterRenderModeTypeAdd(self, color):
		vid = player.GetTargetVID()
		print " -> SetCharacterRenderModeTypeAdd", vid, color
		chr.testSetAddRenderMode(vid, int(color,16))

	def SetCharacterRenderModeTypeMod(self, color):
		vid = player.GetTargetVID()
		print " -> SetCharacterRenderModeTypeMod", vid, color, int(color,16)
		chr.testSetModulateRenderMode(vid, int(color,16))

	def SetCharacterRenderModeTypeAddRGB(self, r, g, b):
		vid = player.GetTargetVID()
		print " -> SetCharacterRenderModeTypeAddRGB", vid, r, g, b
		chr.testSetAddRenderModeRGB(vid, float(r)/255.0, float(g)/255.0, float(b)/255.0)

	def SetCharacterRenderModeTypeModRGB(self, r, g, b):
		vid = player.GetTargetVID()
		print " -> SetCharacterRenderModeTypeModRGB", vid, r, g, b
		chr.testSetModulateRenderModeRGB(vid, float(r)/255.0, float(g)/255.0, float(b)/255.0)

	def SetCharacterRenderModeSpecular(self, alpha):
		vid = player.GetTargetVID()
		print " -> SetCharacterRenderModeSpecular", vid, alpha
		chr.testSetSpecularRenderMode(vid, float(alpha))

	def RestoreCharacterRenderModeType(self):
		vid = player.GetTargetVID()
		chr.testRestoreRenderMode(vid)


	def	ShowNameList(self, lstsName, lstsFilter=None):
		if len(lstsName)==0:
			self.Print("None")
			return

		if lstsFilter:
			isFilter=1
		else:
			isFilter=0

		sLine=""
		iCol=0

		iName=0
		for sName in lstsName:
			if isFilter:
				iDotPos=sName.rfind('.', 0, -1)
				if iDotPos<0:
					iName=iName+1
					continue

				if (sName[iDotPos+1:] in lstsFilter)==0:
					iName=iName+1
					continue

			sLine=sLine+"%3d %-15s " % (iName, sName)

			if iCol>4:
				iCol=0
				self.Print(sLine)
				sLine=""

			iCol=iCol+1

			iName=iName+1

		if ""!=sLine:
			self.Print(sLine)

class ConsoleWindow(ui.Window):

	BACK_GROUND_COLOR = grp.GenerateColor(0.0, 0.0, 0.0, 0.5)
	EDIT_LINE_COLOR = grp.GenerateColor(0.0, 0.0, 0.0, 1.0)
	BUTTON_COLOR = grp.GenerateColor(1.0, 1.0, 1.0, 1.0)
	HEIGHT = 200
	LINE_STEP = 15
	MAX_LINE_COUNT = 50

	class ConsoleEditLine(ui.EditLine):
		def __init__(self):
			ui.EditLine.__init__(self)
			self.eventReturn = 0
			self.eventEscape = 0
		def __del__(self):
			ui.EditLine.__del__(self)

		def SetReturnEvent(self, event):
			self.eventReturn = event

		def SetEscapeEvent(self, event):
			self.eventEscape = event

		def OnIMEReturn(self):
			text = self.GetText()

			if len(text) > 0:
				self.eventReturn(text)

			else:
				wndMgr.KillFocus()
				self.eventEscape()

			self.SetText("")
			return True

		def OnPressEscapeKey(self):
			self.SetText("")
			wndMgr.KillFocus()
			self.eventEscape()
			return True

	class ResizingButton(ui.DragButton):

		BUTTON_NORMAL_COLOR = grp.GenerateColor(0.3320, 0.2929, 0.2578, 1.0)
		BUTTON_OVER_COLOR = grp.GenerateColor(0.5320, 0.4929, 0.4578, 1.0)
		BUTTON_LIGHT_OUTLINE_COLOR = grp.GenerateColor(0.6666, 0.6509, 0.6313, 1.0)
		BUTTON_DARK_OUTLINE_COLOR = grp.GenerateColor(0.1647, 0.1450, 0.1294, 1.0)

		def __init__(self):
			ui.DragButton.__init__(self)
			self.AddFlag("limit")
			self.AddFlag("restrict_x")

		def __del__(self):
			ui.DragButton.__del__(self)

	def __init__(self):
		ui.Window.__init__(self)

		self.TextList = []
		self.game = 0
		self.Console = Console(self)

		self.ResizingButton = self.ResizingButton()
		self.ResizingButton.SetParent(self)
		self.ResizingButton.SetSize(15, 15)
		self.ResizingButton.SetPosition(100, 100)
		self.ResizingButton.Show()

		self.EditLine = self.ConsoleEditLine()
		self.EditLine.SetParent(self)
		self.EditLine.SetMax(100)
		self.EditLine.SetFontName(localeInfo.UI_DEF_FONT)
		self.EditLine.SetText("")
		self.EditLine.Show()

		from _weakref import ref

		self.ResizingButton.SetMoveEvent(lambda s = ref(self): s().UpdatePosition())
		self.EditLine.SetReturnEvent(lambda x,s = ref(self): s().ProcessCommand(x))
		self.EditLine.SetEscapeEvent(lambda s = ref(self): s().CloseWindow())

		self.UpdatePosition()

		self.functionDict = {}
		self.InitFunction()

	def __del__(self):
		ui.Window.__del__(self)

	def BindGameClass(self, game):
		self.Console.BindGameClass(game)

	def Close(self):
		self.Console.Close()
		self.ResizingButton = 0
		self.EditLine = 0

	def SetConsoleSize(self, width, height):
		self.ResizingButton.SetPosition(width-20, height-20)
		self.UpdatePosition()

	def OnRender(self):
		grp.SetColor(self.BACK_GROUND_COLOR)
		grp.RenderBar(self.gx, self.gy, self.width, self.height)

		grp.SetColor(ConsoleWindow.EDIT_LINE_COLOR)
		grp.RenderBar(self.gxEditLine-2, self.gyEditLine-3, self.width - 40, 17)

		grp.SetColor(ConsoleWindow.BUTTON_COLOR)
		grp.RenderBar(self.gxButton-2, self.gyButton-3, self.widthButton, self.heightButton)

	def UpdatePosition(self):

		self.width = self.GetWidth()
		self.height = self.GetHeight()
		self.widthButton = self.ResizingButton.GetWidth()
		self.heightButton = self.ResizingButton.GetHeight()
		(self.gx, self.gy) = self.GetGlobalPosition()
		(self.gxButton, self.gyButton) = self.ResizingButton.GetGlobalPosition()

		self.SetSize(self.gxButton - self.gx + 20, self.gyButton - self.gy + 20)

		self.EditLine.SetSize(self.width-30, 16)
		self.EditLine.SetPosition(7, self.height-20)
		(self.gxEditLine, self.gyEditLine) = self.EditLine.GetGlobalPosition()

		#####

		yPosition = (self.height-20) - self.LINE_STEP
		ItemCount = len(self.TextList)

		for i in xrange(ItemCount):
			TextLine = self.TextList[ItemCount-i-1]

			TextLine.SetPosition(10, yPosition)
			yPosition -= self.LINE_STEP

			if yPosition < 0:
				TextLine.Hide()
			else:
				TextLine.Show()

	def OpenWindow(self):

		self.EditLine.SetFocus()

		self.Show()
		self.Console.RefreshPath()

	def CloseWindow(self):
		self.Hide()

	def ProcessCommand(self, text):

		if '/' == text[0]:
			net.SendChatPacket(text)
			return

		Console=self.Console
		Console.Print(">> "+text)

		lstsArg=text.split()
		if len(lstsArg)==0:
			return

		sCmd=lstsArg[0]

		if self.functionDict.has_key(sCmd):
			try:
				self.functionDict[sCmd](self.Console, *lstsArg[1:])
			except Exception, e:
				Console.Print(str(e))
				#self.Console.Print(e)
				#self.Console.Print(self.functionDict[sCmd].__doc__)
		else:
			if sCmd == 'help' or sCmd == 'h':
				try:
					k = lstsArg[1]
					v = self.functionDict[k]
					argcount = v.im_func.func_code.co_argcount - 1 # -1 for self
					if v.im_func.func_code.co_flags & 4:
						argcount+=1
					argnames = v.im_func.func_code.co_varnames[1:argcount+1]
					if argcount:
						Console.Print("%s(%s) : %s" % (k,argcount, v.__doc__))
						Console.Print("arg : %s" % argnames)
					else:
						Console.Print("%s : %s" % (k,v.__doc__))
				except:
					for k,v in self.functionDict.iteritems():
						argcount = v.im_func.func_code.co_argcount - 1 # -1 for self
						if v.im_func.func_code.co_flags & 4:
							argcount+=1
						if argcount:
							Console.Print("%s(%s) : %s" % (k,argcount, v.__doc__))
						else:
							Console.Print("%s : %s" % (k,v.__doc__))
					Console.Print("? : Tüm komutların listesi")
					Console.Print("h : Tüm komutlar için yardım")
					Console.Print("h blah : blah için yardım")

				Console.Print("")
			elif sCmd == '?':
				list = self.functionDict.keys()
				list.sort()
				Console.ShowNameList(list)
			pass

	def InitFunction(self):
		#self.AddFunction("help",		Console.PrintHelp)
		#self.AddFunction("?",			Console.PrintHelp)

		self.AddFunction("exit",		Console.Exit)
		self.AddFunction("mvol",		Console.SetMusicVolume)
		self.AddFunction("svol",		Console.SetSoundVolume)
		self.AddFunction("snds",		Console.SetSoundScale)
		self.AddFunction("asnds",		Console.SetAmbienceSoundScale)
		self.AddFunction("mspd",		Console.SetMovingSpeed)
		self.AddFunction("pwd",			Console.ShowPath)
		self.AddFunction("ls", 			Console.ShowList)
		self.AddFunction("shadow",		Console.SetShadowLevel)
		self.AddFunction("splat",		Console.SetSplatLimit)
		self.AddFunction("distance", 	Console.SelectViewDistanceNum)
		self.AddFunction("bgloading",	Console.SetBGLoading)
		self.AddFunction("terrainrender",	Console.SetTerrainRenderSort)
		self.AddFunction("transtree",		Console.SetTransparentTree)
		self.AddFunction("stune",		Console.SetStunEffect)
		self.AddFunction("duste",		Console.SetDustEffect)
		self.AddFunction("dustt",		Console.SetDustGap)
		self.AddFunction("hite",		Console.SetHitEffect)
		self.AddFunction("cd",			Console.MoveChildPath)
		self.AddFunction("up",			Console.MoveParentPath)
		self.AddFunction("lsd",			Console.ShowDirList)
		self.AddFunction("lsf",			Console.ShowFileList)
		self.AddFunction("lse",			Console.ShowEffectList)
		self.AddFunction("show",		Console.ShowBackgroundPart)
		self.AddFunction("hide",		Console.HideBackgroundPart)
		self.AddFunction("debuginfo",	Console.ToggleDebugInfo)

		self.AddFunction("collision",	Console.SetCollision)
		self.AddFunction("colli",	Console.SetCollision)

		#self.AddFunction("wt",	Console.SetWeaponTrace)
		self.AddFunction("wtt",	Console.SetWeaponTraceTexture)
		self.AddFunction("wtm",	Console.SetWeaponTraceMode)

		self.AddFunction("disconnect",	Console.Disconnect)
		self.AddFunction("autorot", Console.SetAutoCameraRotationSpeed)

		self.AddFunction("dirline", Console.ToggleActorDirectionLine)
		self.AddFunction("pickc", Console.ShowPickedCharacterInfo)
		self.AddFunction("infoc", Console.ShowCharacterInfo)
		self.AddFunction("regchre", Console.RegisterCharacterEffect)
		self.AddFunction("setchra", Console.SetCharacterAffect)
		self.AddFunction("emoticon", Console.SetCharacterEmoticon)
		self.AddFunction("perfinfo", Console.ShowPerformanceInfo)
		self.AddFunction("reload_locale", Console.ReloadLocale)
		self.AddFunction("re", Console.ReloadDevel)
		self.AddFunction("perftime", Console.EnablePerformanceTime)
		self.AddFunction("cooltime", Console.SetCoolTime)
		self.AddFunction("levellimit", Console.SetLevelLimit)
		self.AddFunction("showcursor", Console.ShowCursor)
		self.AddFunction("hidecursor", Console.HideCursor)

		self.AddFunction("warp", Console.WarpTest)
		self.AddFunction("web", Console.ShowWeb)

		self.AddFunction("showui", Console.ShowUI)
		self.AddFunction("hideui", Console.HideUI)

		self.AddFunction("setcspd", Console.SetCameraSpeed)
		self.AddFunction("savecmr", Console.SaveCameraSetting)
		self.AddFunction("loadcmr", Console.LoadCameraSetting)
		self.AddFunction("setdefcmr", Console.SetDefaultCamera)

		self.AddFunction("showclock", Console.ShowClock)
		self.AddFunction("hideclock", Console.HideClock)

		self.AddFunction("setsight", Console.SetSight)

		self.AddFunction("setcombotip", Console.SetComboType)
		self.AddFunction("setsk_fake", Console.SetSkillGroupFake)

		self.AddFunction("trans", Console.SetEmpireLanguageMode)

		self.AddFunction("shownotice", Console.ShowNotice)
		self.AddFunction("hidenotice", Console.HideNotice)

		self.AddFunction("setrmadd", Console.SetCharacterRenderModeTypeAdd)
		self.AddFunction("setrmmod", Console.SetCharacterRenderModeTypeMod)
		self.AddFunction("setrmaddrgb", Console.SetCharacterRenderModeTypeAddRGB)
		self.AddFunction("setrmmodrgb", Console.SetCharacterRenderModeTypeModRGB)
		self.AddFunction("setspec", Console.SetCharacterRenderModeSpecular)
		self.AddFunction("restorerm", Console.RestoreCharacterRenderModeType)

	def AddFunction(self, cmd, func):
		self.functionDict[cmd] = func

	def Print(self, text):
		TextLine = ui.TextLine()
		TextLine.SetParent(self)
		TextLine.SetFontName(localeInfo.UI_DEF_FONT)
		TextLine.Show()
		TextLine.SetText(text)
		self.TextList.append(TextLine)

		count = len(self.TextList)
		if count > self.MAX_LINE_COUNT:
			for i in xrange(count - self.MAX_LINE_COUNT):
				del self.TextList[0]

		self.UpdatePosition()
