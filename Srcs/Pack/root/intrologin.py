import dbg
import app
import net
import ui
import ime
import snd
import wndMgr
import musicInfo
import serverInfo
import systemSetting
import ServerStateChecker
import localeInfo
import constInfo
import uiCommon
import time
import serverCommandParser
import ime
import uiScriptLocale

LOGIN_DELAY_SEC = app.LOGIN_DELAY_SEC
SKIP_LOGIN_PHASE = app.SKIP_LOGIN_PHASE
SKIP_LOGIN_PHASE_SUPPORT_CHANNEL = app.SKIP_LOGIN_PHASE_SUPPORT_CHANNEL
FULL_BACK_IMAGE = app.FULL_BACK_IMAGE

def IsFullBackImage():
	global FULL_BACK_IMAGE
	return FULL_BACK_IMAGE

def IsLoginDelay():
	global LOGIN_DELAY_SEC
	if LOGIN_DELAY_SEC > 0.0:
		return True
	else:
		return False

def GetLoginDelay():
	global LOGIN_DELAY_SEC
	return LOGIN_DELAY_SEC

app.SetGuildMarkPath("test")

class ConnectingDialog(ui.ScriptWindow):

	def __init__(self):
		ui.ScriptWindow.__init__(self)
		self.__LoadDialog()
		self.eventTimeOver = lambda *arg: None
		self.eventExit = lambda *arg: None

	def __del__(self):
		ui.ScriptWindow.__del__(self)

	def __LoadDialog(self):
		try:
			PythonScriptLoader = ui.PythonScriptLoader()
			PythonScriptLoader.LoadScriptFile(self, "UIScript/ConnectingDialog.py")

			self.board = self.GetChild("board")
			self.message = self.GetChild("message")
			self.countdownMessage = self.GetChild("countdown_message")

		except:
			import exception
			exception.Abort("ConnectingDialog.LoadDialog.BindObject")

	def Open(self, waitTime):
		curTime = time.clock()
		self.endTime = curTime + waitTime

		self.Lock()
		self.SetCenterPosition()
		self.SetTop()
		self.Show()

	def Close(self):
		self.Unlock()
		self.Hide()

	@ui.WindowDestroy
	def Destroy(self):
		self.Hide()
		self.ClearDictionary()

	def SetText(self, text):
		self.message.SetText(text)

	def SetCountDownMessage(self, waitTime):
		self.countdownMessage.SetText("%.0f%s" % (waitTime, localeInfo.SECOND))

	def SAFE_SetTimeOverEvent(self, event):
		self.eventTimeOver = ui.__mem_func__(event)

	def SAFE_SetExitEvent(self, event):
		self.eventExit = ui.__mem_func__(event)

	def OnUpdate(self):
		lastTime = max(0, self.endTime - time.clock())
		if 0 == lastTime:
			self.Close()
			self.eventTimeOver()
		else:
			self.SetCountDownMessage(self.endTime - time.clock())

	def OnPressExitKey(self):
		#self.eventExit()
		return True

class LoginWindow(ui.ScriptWindow):

	IS_TEST = net.IsTest()

	def __init__(self, stream):
		print "YENI GIRIS PENCERESI ----------------------------------------------------------------------------"
		ui.ScriptWindow.__init__(self)
		net.SetPhaseWindow(net.PHASE_WINDOW_LOGIN, self)
		net.SetAccountConnectorHandler(self)

		self.lastLoginTime = 0
		self.inputDialog = None
		self.connectingDialog = None
		self.stream=stream
		self.isNowCountDown=False
		self.isStartError=False
		self.channelBtnList = []

		self.xServerBoard = 0
		self.yServerBoard = 0

		self.loadingImage = None

		# @fixme001 BEGIN (timeOutMsg and timeOutOk undefined)
		self.timeOutMsg = False
		self.timeOutOk = False
		# @fixme001 END


	def __del__(self):
		net.ClearPhaseWindow(net.PHASE_WINDOW_LOGIN, self)
		net.SetAccountConnectorHandler(0)
		ui.ScriptWindow.__del__(self)
		print "---------------------------------------------------------------------------- GIRIS PENCERESI SIL"

	def Open(self):
		ServerStateChecker.Create(self)

		print "GIRIS PENCERESI AC ----------------------------------------------------------------------------"

		self.loginFailureMsgDict={
			#"DEFAULT" : localeInfo.LOGIN_FAILURE_UNKNOWN,

			"ALREADY"	: localeInfo.LOGIN_FAILURE_ALREAY,
			"NOID"		: localeInfo.LOGIN_FAILURE_NOT_EXIST_ID,
			"WRONGPWD"	: localeInfo.LOGIN_FAILURE_WRONG_PASSWORD,
			"FULL"		: localeInfo.LOGIN_FAILURE_TOO_MANY_USER,
			"SHUTDOWN"	: localeInfo.LOGIN_FAILURE_SHUTDOWN,
			"REPAIR"	: localeInfo.LOGIN_FAILURE_REPAIR_ID,
			"BLOCK"		: localeInfo.LOGIN_FAILURE_BLOCK_ID,
			"WRONGMAT"	: localeInfo.LOGIN_FAILURE_WRONG_MATRIX_CARD_NUMBER,
			"QUIT"		: localeInfo.LOGIN_FAILURE_WRONG_MATRIX_CARD_NUMBER_TRIPLE,
			"BESAMEKEY"	: localeInfo.LOGIN_FAILURE_BE_SAME_KEY,
			"NOTAVAIL"	: localeInfo.LOGIN_FAILURE_NOT_AVAIL,
			"NOBILL"	: localeInfo.LOGIN_FAILURE_NOBILL,
			"BLKLOGIN"	: localeInfo.LOGIN_FAILURE_BLOCK_LOGIN,
			"WEBBLK"	: localeInfo.LOGIN_FAILURE_WEB_BLOCK,
			"BADSCLID"	: localeInfo.LOGIN_FAILURE_WRONG_SOCIALID,
			"AGELIMIT"	: localeInfo.LOGIN_FAILURE_SHUTDOWN_TIME,
		}

		self.loginFailureFuncDict = {
			"WRONGPWD"	: self.__DisconnectAndInputPassword,
			"QUIT"		: app.Exit,
		}

		self.SetSize(wndMgr.GetScreenWidth(), wndMgr.GetScreenHeight())
		self.SetWindowName("LoginWindow")

		if not self.__LoadScript(uiScriptLocale.LOCALE_UISCRIPT_PATH + "LoginWindow.py"):
			dbg.TraceError("LoginWindow.Open - __LoadScript Hatası")
			return

		self.__LoadLoginInfo("loginInfo.xml")

		if app.loggined:
			self.loginFailureFuncDict = {
			"WRONGPWD"	: app.Exit,
			"WRONGMAT"	: app.Exit,
			"QUIT"		: app.Exit,
			}

		if musicInfo.loginMusic != "":
			snd.SetMusicVolume(systemSetting.GetMusicVolume())
			snd.FadeInMusic("BGM/"+musicInfo.loginMusic)

		snd.SetSoundVolume(systemSetting.GetSoundVolume())

		# pevent key "[" "]"
		ime.AddExceptKey(91)
		ime.AddExceptKey(93)

		self.Show()

		global SKIP_LOGIN_PHASE
		if SKIP_LOGIN_PHASE:
			if self.isStartError:
				self.connectBoard.Hide()
				self.loginBoard.Hide()
				if app.ENABLE_SAVE_ACCOUNT:
					self.saveAccountBoard.Hide()
				self.serverBoard.Hide()
				self.PopupNotifyMessage(localeInfo.LOGIN_CONNECT_FAILURE, self.__ExitGame)
				return

			if self.loginInfo:
				self.serverBoard.Hide()
			else:
				self.__RefreshServerList()
				self.__OpenServerBoard()
		else:
			self.__RefreshServerList()
			self.__OpenServerBoard()

		app.ShowCursor()

	def Close(self):

		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		ServerStateChecker.Initialize(self)

		print "---------------------------------------------------------------------------- GIRIS PENCERESI KAPAT "
		#
		#
		if musicInfo.loginMusic != "" and musicInfo.selectMusic != "":
			snd.FadeOutMusic("BGM/"+musicInfo.loginMusic)

		self.idEditLine.SetTabEvent(0)
		self.idEditLine.SetReturnEvent(0)
		self.pwdEditLine.SetReturnEvent(0)
		self.pwdEditLine.SetTabEvent(0)

		self.connectBoard = None
		self.loginBoard = None
		if app.ENABLE_SAVE_ACCOUNT:
			self.saveAccountBoard = None
		self.idEditLine = None
		self.pwdEditLine = None
		self.inputDialog = None
		self.connectingDialog = None
		self.loadingImage = None

		self.serverBoard				= None
		self.serverList					= None
		self.channelList				= None
		self.channelBtnList				= None

		self.KillFocus()
		self.Hide()

		self.stream.popupWindow.Close()
		self.loginFailureFuncDict=None

		ime.ClearExceptKey()

		app.HideCursor()

	def __SaveChannelInfo(self):
		try:
			file=old_open("channel.inf", "w")
			file.write("%d %d %d" % (self.__GetServerID(), self.__GetChannelID(), self.__GetRegionID()))
		except:
			print "LoginWindow.__SaveChannelInfo - KaydetmeHatası"

	def __LoadChannelInfo(self):
		try:
			file=old_open("channel.inf")
			lines=file.readlines()

			if len(lines)>0:
				tokens=lines[0].split()

				selServerID=int(tokens[0])
				selChannelID=int(tokens[1])

				if len(tokens) == 3:
					regionID = int(tokens[2])

				return regionID, selServerID, selChannelID

		except:
			print "LoginWindow.__LoadChannelInfo - AçmaHatası"
			return -1, -1, -1

	def __ExitGame(self):
		app.Exit()

	def SetIDEditLineFocus(self):
		if self.idEditLine != None:
			self.idEditLine.SetFocus()

	def SetPasswordEditLineFocus(self):
		if app.ENABLE_CLEAN_DATA_IF_FAIL_LOGIN:
			if self.idEditLine != None:
				self.idEditLine.SetText("")
				self.idEditLine.SetFocus()

			if self.pwdEditLine != None:
				self.pwdEditLine.SetText("")
		else:
			if self.pwdEditLine != None:
				self.pwdEditLine.SetFocus()

	def OnEndCountDown(self):
		self.isNowCountDown = False
		self.timeOutMsg = False
		self.OnConnectFailure()

	def OnConnectFailure(self):

		if self.isNowCountDown:
			return

		snd.PlaySound("sound/ui/loginfail.wav")

		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		if app.loggined:
			self.PopupNotifyMessage(localeInfo.LOGIN_CONNECT_FAILURE, self.__ExitGame)
		elif self.timeOutMsg:
			self.PopupNotifyMessage(localeInfo.LOGIN_FAILURE_TIMEOUT, self.SetPasswordEditLineFocus)
		else:
			self.PopupNotifyMessage(localeInfo.LOGIN_CONNECT_FAILURE, self.SetPasswordEditLineFocus)

	def OnHandShake(self):
		if not IsLoginDelay():
			snd.PlaySound("sound/ui/loginok.wav")
			self.PopupDisplayMessage(localeInfo.LOGIN_CONNECT_SUCCESS)

	def OnLoginStart(self):
		if not IsLoginDelay():
			self.PopupDisplayMessage(localeInfo.LOGIN_PROCESSING)

	def OnLoginFailure(self, error):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		try:
			loginFailureMsg = self.loginFailureMsgDict[error]
		except KeyError:
			loginFailureMsg = localeInfo.LOGIN_FAILURE_UNKNOWN + error


		loginFailureFunc=self.loginFailureFuncDict.get(error, self.SetPasswordEditLineFocus)

		if app.loggined:
			self.PopupNotifyMessage(loginFailureMsg, self.__ExitGame)
		else:
			self.PopupNotifyMessage(loginFailureMsg, loginFailureFunc)

		snd.PlaySound("sound/ui/loginfail.wav")

	def __DisconnectAndInputID(self):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		self.SetIDEditLineFocus()
		net.Disconnect()

	def __DisconnectAndInputPassword(self):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		self.SetPasswordEditLineFocus()
		net.Disconnect()

	if app.ENABLE_SAVE_ACCOUNT:
		def SAB_LoadAccountData(self):
			if constInfo.SAB.storeType == constInfo.SAB.ST_CACHE:
				return
			for idx in xrange(constInfo.SAB.slotCount):
				if constInfo.SAB.storeType == constInfo.SAB.ST_REGISTRY:
					id = constInfo.GetWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValueId))
					pwd = constInfo.GetWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValuePwd))
					if id and pwd:
						self.SAB_SetAccountData(idx, (id, pwd))
				elif constInfo.SAB.storeType == constInfo.SAB.ST_FILE:
					(id, pwd) = constInfo.GetJsonSABData(idx)
					if id and pwd:
						self.SAB_SetAccountData(idx, (id, pwd))

		def SAB_SaveAccountData(self):
			if constInfo.SAB.storeType == constInfo.SAB.ST_CACHE:
				return
			for idx in xrange(constInfo.SAB.slotCount):
				if constInfo.SAB.storeType == constInfo.SAB.ST_REGISTRY:
					_tSlot = self.SAB_GetAccountData(idx)
					if _tSlot:
						(id, pwd) = _tSlot
						constInfo.SetWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValueId), id)
						constInfo.SetWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValuePwd), pwd)
					else:
						constInfo.DelWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValueId))
						constInfo.DelWinRegKeyValue(constInfo.SAB.regPath, constInfo.SAB.regName % (idx, constInfo.SAB.regValuePwd))
				elif constInfo.SAB.storeType == constInfo.SAB.ST_FILE:
					_tSlot = self.SAB_GetAccountData(idx)
					if _tSlot:
						constInfo.SetJsonSABData(idx, _tSlot)
					else:
						constInfo.DelJsonSABData(idx)

		def SAB_DelAccountData(self, slot):
			if constInfo.SAB.accData.get(slot):
				del constInfo.SAB.accData[slot]

		def SAB_GetAccountData(self, slot):
			return constInfo.SAB.accData.get(slot)

		def SAB_SetAccountData(self, slot, data):
			constInfo.SAB.accData[slot] = data

		def SAB_BtnRearrange(self):
			GetObject=self.GetChild
			btnNameSave = constInfo.SAB.btnName["Save"]
			btnNameAccess = constInfo.SAB.btnName["Access"]
			btnNameRemove = constInfo.SAB.btnName["Remove"]
			for idx in xrange(constInfo.SAB.slotCount):
				_tSlot = self.SAB_GetAccountData(idx)
				btnObjSave = GetObject(btnNameSave % idx)
				btnObjAccess = GetObject(btnNameAccess % idx)
				btnObjRemove = GetObject(btnNameRemove % idx)
				btnObjRemove.Hide()
				if _tSlot:
					(id, pwd) = _tSlot
					btnObjSave.Hide()
					btnObjAccess.Show()
					btnObjAccess.SetText(id)
					btnObjAccess.SetTextColor(0xFFFFFFFF)
					btnObjAccess.SetToolTipText(uiScriptLocale.SAVE_ACCOUNT_REMOVE_TIP)
				else:
					btnObjSave.Show()
					btnObjSave.SetText(uiScriptLocale.SAVE_ACCOUNT_EMPTY)
					btnObjSave.SetTextColor(0xFFB0B0B0)
					btnObjSave.SetToolTipText(uiScriptLocale.SAVE_ACCOUNT_SAVE)
					btnObjAccess.Hide()

		def SAB_Click_Save(self, slot):
			if slot >= constInfo.SAB.slotCount:
				return
			## def code
			GetObject=self.GetChild
			SetObject=self.InsertChild
			## button stuff
			_tmpName = constInfo.SAB.btnName["Save"] % slot
			_tmpObj = GetObject(_tmpName)
			## code stuff
			try:
				id = self.idEditLine.GetText()
				pwd = self.pwdEditLine.GetText()

				if len(id)==0:
					self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_ID, self.SetIDEditLineFocus)
					return

				if len(pwd)==0:
					self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_PASSWORD, self.SetPasswordEditLineFocus)
					return
			except:
				return
			self.SAB_SetAccountData(slot, (id,pwd))
			self.SAB_SaveAccountData()
			## rearrange stuff
			self.SAB_BtnRearrange()

		def SAB_Click_Access(self, slot):
			if slot >= constInfo.SAB.slotCount:
				return
			## def code
			GetObject=self.GetChild
			SetObject=self.InsertChild
			## button stuff
			_tmpName = constInfo.SAB.btnName["Access"] % slot
			_tmpObj = GetObject(_tmpName)
			## code stuff
			_tSlot = self.SAB_GetAccountData(slot)
			if _tSlot:
				(id, pwd) = _tSlot
				self.idEditLine.SetText(id)
				self.pwdEditLine.SetText(pwd)
				self.__OnClickLoginButton()

		def SAB_Click_Remove(self, slot):
			if slot >= constInfo.SAB.slotCount:
				return
			## def code
			GetObject=self.GetChild
			SetObject=self.InsertChild
			## button stuff
			_tmpName = constInfo.SAB.btnName["Remove"] % slot
			_tmpObj = GetObject(_tmpName)
			## code stuff
			self.SAB_DelAccountData(slot)
			self.SAB_SaveAccountData()
			## rearrange stuff
			self.SAB_BtnRearrange()

		def __CreateSaveAccountBoard(self):
			self.SAB_LoadAccountData()
			GetObject=self.GetChild
			SetObject=self.InsertChild
			# loginwindow.py ile ayni olcu: x=14, baslangic y=34, adim=28
			BTN_X = 14
			BTN_Y = 34
			SPACE_FOR_BUTTON = 28
			btnNameSave = constInfo.SAB.btnName["Save"]
			btnNameAccess = constInfo.SAB.btnName["Access"]
			btnNameRemove = constInfo.SAB.btnName["Remove"]
			btnImage = {"default":1, "over":2, "down":3}
			_tmpBtnPath = "d:/ymir work/ui/public/xlarge_button_%02d.sub"
			try:
				self.saveAccountBoard = GetObject("SaveAccountBoard")
			except:
				import exception; exception.Abort("__CreateSaveAccountBoard SAB BOARD")
			for idx in xrange(constInfo.SAB.slotCount):
				try:
					_tmpName = btnNameSave % (idx)
					SetObject(_tmpName, ui.Button())
					_tmpObj = GetObject(_tmpName)
					_tmpObj.SetParent(self.saveAccountBoard)
					_tmpObj.SetUpVisual(_tmpBtnPath % (btnImage["default"]))
					_tmpObj.SetOverVisual(_tmpBtnPath % (btnImage["over"]))
					_tmpObj.SetDownVisual(_tmpBtnPath % (btnImage["down"]))
					_tmpObj.SetText(uiScriptLocale.SAVE_ACCOUNT_EMPTY)
					_tmpObj.SAFE_SetEvent(self.SAB_Click_Save, idx)
					_tmpObj.SetPosition(BTN_X, BTN_Y + (idx * SPACE_FOR_BUTTON))
					_tmpObj.Hide()
				except:
					import exception; exception.Abort("__CreateSaveAccountBoard SAB SAVE")
				try:
					_tmpName = btnNameAccess % (idx)
					SetObject(_tmpName, ui.Button())
					_tmpObj = GetObject(_tmpName)
					_tmpObj.SetParent(self.saveAccountBoard)
					_tmpObj.SetUpVisual(_tmpBtnPath % (btnImage["default"]))
					_tmpObj.SetOverVisual(_tmpBtnPath % (btnImage["over"]))
					_tmpObj.SetDownVisual(_tmpBtnPath % (btnImage["down"]))
					_tmpObj.SAFE_SetEvent(self.SAB_Click_Access, idx)
					_tmpObj.OnMouseRightButtonDown = lambda slot=idx: self.SAB_Click_Remove(slot)
					_tmpObj.SetPosition(BTN_X, BTN_Y + (idx * SPACE_FOR_BUTTON))
					_tmpObj.Show()
				except:
					import exception; exception.Abort("__CreateSaveAccountBoard SAB ACCESS")
				try:
					_tmpName = btnNameRemove % (idx)
					SetObject(_tmpName, ui.Button())
					_tmpObj = GetObject(_tmpName)
					_tmpObj.SetParent(self.saveAccountBoard)
					_tmpObj.SetUpVisual(_tmpBtnPath % (btnImage["default"]))
					_tmpObj.SetOverVisual(_tmpBtnPath % (btnImage["over"]))
					_tmpObj.SetDownVisual(_tmpBtnPath % (btnImage["down"]))
					_tmpObj.SAFE_SetEvent(self.SAB_Click_Remove, idx)
					_tmpObj.SetPosition(BTN_X, BTN_Y + (idx * SPACE_FOR_BUTTON))
					_tmpObj.Hide()
				except:
					import exception; exception.Abort("__CreateSaveAccountBoard SAB REMOVE")
			self.SAB_BtnRearrange()

	def __CreateChannelBar(self):
		GetObject=self.GetChild
		SetObject=self.InsertChild
		for idx in xrange(8):
			_tmpName = "LoginChannelButton_%02d" % idx
			SetObject(_tmpName, ui.Button())
			_tmpObj = GetObject(_tmpName)
			_tmpObj.SetParent(self.serverBoard)
			_tmpBtnPath = "d:/ymir work/ui/public/xlarge_button_%02d.sub"
			_tmpObj.SetUpVisual(_tmpBtnPath % 1)
			_tmpObj.SetOverVisual(_tmpBtnPath % 2)
			_tmpObj.SetDownVisual(_tmpBtnPath % 3)
			_tmpObj.SAFE_SetEvent(self.__OnClickChannelButton, idx)
			_tmpObj.Hide()
			self.channelBtnList.append(_tmpObj)

	def __OnClickChannelButton(self, idx):
		self.channelList.SelectItem(idx)
		self.__RefreshChannelBarSel()
		self.__ApplySelectedServer()

	def __RefreshChannelBar(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()

		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except:
			channelDict = {}

		# loginwindow.py ServerBoard icinde dikey liste
		BTN_X = 14
		BTN_Y = 34
		BTN_STEP = 28

		idx = 0
		for channelID, channelDataDict in channelDict.items():
			if idx >= len(self.channelBtnList):
				break
			btn = self.channelBtnList[idx]
			btn.SetText(channelDataDict["name"])
			btn.SetPosition(BTN_X, BTN_Y + idx * BTN_STEP)
			btn.Show()
			idx += 1

		for j in xrange(idx, len(self.channelBtnList)):
			self.channelBtnList[j].Hide()

		self.__RefreshChannelBarSel()

	def __RefreshChannelBarSel(self):
		sel = self.channelList.selectedLine
		for idx in xrange(len(self.channelBtnList)):
			if idx == sel:
				self.channelBtnList[idx].Down()
			else:
				self.channelBtnList[idx].SetUp()

	def __LoadScript(self, fileName):
		import dbg
		try:
			pyScrLoader = ui.PythonScriptLoader()
			pyScrLoader.LoadScriptFile(self, fileName)
		except:
			import exception
			exception.Abort("LoginWindow.__LoadScript.LoadObject")
		try:
			GetObject=self.GetChild
			self.serverBoard			= GetObject("ServerBoard")
			self.serverList				= GetObject("ServerList")
			self.channelList			= GetObject("ChannelList")
			self.serverSelectButton		= GetObject("ServerSelectButton")
			self.serverExitButton		= GetObject("ServerExitButton")
			self.connectBoard			= GetObject("ConnectBoard")
			self.loginBoard				= GetObject("LoginBoard")
			self.idEditLine				= GetObject("ID_EditLine")
			self.pwdEditLine			= GetObject("Password_EditLine")
			self.serverInfo				= GetObject("ConnectName")
			self.selectConnectButton	= GetObject("SelectConnectButton")
			self.loginButton			= GetObject("LoginButton")
			self.loginExitButton		= GetObject("LoginExitButton")

			if app.ENABLE_SAVE_ACCOUNT:
				self.__CreateSaveAccountBoard()

		except:
			import exception
			exception.Abort("LoginWindow.__LoadScript.BindObject")

		self.selectConnectButton.SetEvent(ui.__mem_func__(self.__OnClickSelectConnectButton))
		self.selectConnectButton.Hide()

		self.serverBoard.OnKeyUp = ui.__mem_func__(self.__ServerBoard_OnKeyUp)
		self.xServerBoard, self.yServerBoard = self.serverBoard.GetLocalPosition()

		self.serverSelectButton.SetEvent(ui.__mem_func__(self.__OnClickSelectServerButton))
		self.serverExitButton.SetEvent(ui.__mem_func__(self.__OnClickExitButton))
		self.serverExitButton.Hide()

		self.loginButton.SetEvent(ui.__mem_func__(self.__OnClickLoginButton))
		self.loginExitButton.SetEvent(ui.__mem_func__(self.__OnClickExitButton))

		self.serverList.SetEvent(ui.__mem_func__(self.__OnSelectServer))

		self.idEditLine.SetReturnEvent(ui.__mem_func__(self.pwdEditLine.SetFocus))
		self.idEditLine.SetTabEvent(ui.__mem_func__(self.pwdEditLine.SetFocus))

		self.pwdEditLine.SetReturnEvent(ui.__mem_func__(self.__OnClickLoginButton))
		self.pwdEditLine.SetTabEvent(ui.__mem_func__(self.idEditLine.SetFocus))

		self.serverList.Hide()
		self.channelList.Hide()
		self.serverSelectButton.Hide()
		self.connectBoard.Hide()
		self.__CreateChannelBar()

		if IsFullBackImage():
			self.GetChild("bg1").Show()
			self.GetChild("bg2").Hide()
		return 1

	def Connect(self, id, pwd):

		if app.SEQUENCE_PACKET_ENABLE:
			net.SetPacketSequenceMode()

		if IsLoginDelay():
			loginDelay = GetLoginDelay()
			self.connectingDialog = ConnectingDialog()
			self.connectingDialog.Open(loginDelay)
			self.connectingDialog.SAFE_SetTimeOverEvent(self.OnEndCountDown)
			self.connectingDialog.SAFE_SetExitEvent(self.OnPressExitKey)
			self.isNowCountDown = True

		else:
			self.stream.popupWindow.Close()
			self.stream.popupWindow.Open(localeInfo.LOGIN_CONNETING, self.SetPasswordEditLineFocus, localeInfo.UI_CANCEL)

		self.stream.SetLoginInfo(id, pwd)
		self.stream.Connect()

	def __OnClickExitButton(self):
		self.stream.SetPhaseWindow(0)

	def __SetServerInfo(self, name):
		net.SetServerInfo(name.strip())
		self.serverInfo.SetText(name)

	def __LoadLoginInfo(self, loginInfoFileName):
		def getValue(element, name, default):
			if [] != element.getElementsByTagName(name):
				return element.getElementsByTagName(name).item(0).firstChild.nodeValue
			else:
				return default

		self.id = None
		self.pwd = None
		self.loginnedServer = None
		self.loginnedChannel = None
		app.loggined = False

		self.loginInfo = False

		from xml.dom.minidom import parse
		try:
			f = old_open(loginInfoFileName, "r")
			dom = parse(f)
		except:
			return
		serverLst = dom.getElementsByTagName("server")
		if [] != dom.getElementsByTagName("logininfo"):
			logininfo = dom.getElementsByTagName("logininfo")[0]
		else:
			return

		try:
			server_name = logininfo.getAttribute("name")
			channel_idx = int(logininfo.getAttribute("channel_idx"))
		except:
			return

		try:
			matched = False

			for k, v in serverInfo.REGION_DICT[0].iteritems():
				if v["name"] == server_name:
					account_addr = serverInfo.REGION_AUTH_SERVER_DICT[0][k]["ip"]
					account_port = serverInfo.REGION_AUTH_SERVER_DICT[0][k]["port"]

					channel_info = v["channel"][channel_idx]
					channel_name = channel_info["name"]
					addr = channel_info["ip"]
					port = channel_info["tcp_port"]

					net.SetMarkServer(addr, port)
					self.stream.SetConnectInfo(addr, port, account_addr, account_port)

					matched = True
					break

			if False == matched:
				return
		except:
			return

		self.loginInfo = True
		self.__SetServerInfo("%s, %s " % (server_name, channel_name))
		id = getValue(logininfo, "id", "")
		pwd = getValue(logininfo, "pwd", "")
		self.idEditLine.SetText(id)
		self.pwdEditLine.SetText(pwd)
		slot = getValue(logininfo, "slot", "0")
		locale = getValue(logininfo, "locale", "")
		locale_dir = getValue(logininfo, "locale_dir", "")
		is_auto_login = int(getValue(logininfo, "auto_login", "0"))

		self.stream.SetCharacterSlot(int(slot))
		self.stream.isAutoLogin=is_auto_login
		self.stream.isAutoSelect=is_auto_login

		if locale and locale_dir:
			app.ForceSetLocale(locale, locale_dir)

		if 0 != is_auto_login:
			self.Connect(id, pwd)

		return


	def PopupDisplayMessage(self, msg):
		self.stream.popupWindow.Close()
		if app.__BL_MULTI_LANGUAGE__:
			self.stream.popupWindow.Open(msg, 0, localeInfo.UI_CANCEL)
		else:
			self.stream.popupWindow.Open(msg)

	def PopupNotifyMessage(self, msg, func=0):
		if not func:
			func=self.EmptyFunc

		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(msg, func, localeInfo.UI_OK)

	def __OnCloseInputDialog(self):
		if self.inputDialog:
			self.inputDialog.Close()
		self.inputDialog = None
		return True

	def OnPressExitKey(self):
		self.stream.popupWindow.Close()
		self.stream.SetPhaseWindow(0)
		return True

	def OnExit(self):
		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(localeInfo.LOGIN_FAILURE_WRONG_MATRIX_CARD_NUMBER_TRIPLE, app.Exit, localeInfo.UI_OK)

	def OnUpdate(self):
		ServerStateChecker.Update()

	def EmptyFunc(self):
		pass

	#####################################################################################

	def __ServerBoard_OnKeyUp(self, key):
		if self.serverBoard.IsShow():
			if app.DIK_RETURN==key:
				self.__OnClickSelectServerButton()
		return True

	def __GetRegionID(self):
		return 0

	def __GetServerID(self):
		return self.serverList.GetSelectedItem()

	def __GetChannelID(self):
		return self.channelList.GetSelectedItem()

	# SEVER_LIST_BUG_FIX
	def __ServerIDToServerIndex(self, regionID, targetServerID):
		try:
			regionDict = serverInfo.REGION_DICT[regionID]
		except KeyError:
			return -1

		retServerIndex = 0
		for eachServerID, regionDataDict in regionDict.items():
			if eachServerID == targetServerID:
				return retServerIndex

			retServerIndex += 1

		return -1

	def __ChannelIDToChannelIndex(self, channelID):
		return channelID - 1
	# END_OF_SEVER_LIST_BUG_FIX

	def __OpenServerBoard(self):

		loadRegionID, loadServerID, loadChannelID = self.__LoadChannelInfo()

		serverIndex = self.__ServerIDToServerIndex(loadRegionID, loadServerID)
		channelIndex = self.__ChannelIDToChannelIndex(loadChannelID)

		if serverIndex < 0:
			serverIndex = 0
		self.serverList.SelectItem(serverIndex)

		if app.ENABLE_RANDOM_CHANNEL_SEL:
			self.channelList.SelectItem(app.GetRandom(0, self.channelList.GetItemCount()))
		else:
			if channelIndex >= 0:
				self.channelList.SelectItem(channelIndex)

		if self.channelList.selectedLine < 0 and self.channelList.GetItemCount() > 0:
			self.channelList.SelectItem(0)

		self.serverBoard.SetPosition(self.xServerBoard, self.yServerBoard)
		self.serverBoard.Show()
		if not app.loggined and not self.stream.isAutoLogin:
			self.loginBoard.Show()
			if app.ENABLE_SAVE_ACCOUNT:
				self.saveAccountBoard.Show()

		self.__RefreshChannelBarSel()
		self.KillInputFocus() #@fixme019

		if app.loggined and not SKIP_LOGIN_PHASE_SUPPORT_CHANNEL:
			self.serverList.SelectItem(self.loginnedServer-1)
			self.channelList.SelectItem(self.loginnedChannel-1)
			self.__OnClickSelectServerButton()

	def KillInputFocus(self): #@fixme019
		if self.idEditLine and self.idEditLine.IsFocus():
			self.idEditLine.KillFocus()
		if self.pwdEditLine and self.pwdEditLine.IsFocus():
			self.pwdEditLine.KillFocus()

	def __OpenLoginBoard(self):

		self.serverBoard.SetPosition(self.xServerBoard, self.yServerBoard)
		self.serverBoard.Show()

		if app.loggined:
			self.Connect(self.id, self.pwd)
			self.connectBoard.Hide()
			self.loginBoard.Hide()
			self.serverBoard.Hide()
			if app.ENABLE_SAVE_ACCOUNT:
				self.saveAccountBoard.Hide()
		elif not self.stream.isAutoLogin:
			self.loginBoard.Show()
			if app.ENABLE_SAVE_ACCOUNT:
				self.saveAccountBoard.Show()

		## if users have the login infomation, then don't initialize.2005.9 haho
		if self.idEditLine == None:
			self.idEditLine.SetText("")
		if self.pwdEditLine == None:
			self.pwdEditLine.SetText("")

		self.idEditLine.SetFocus()

		global SKIP_LOGIN_PHASE
		if SKIP_LOGIN_PHASE:
			if not self.loginInfo:
				self.connectBoard.Hide()

	def __OnSelectRegionGroup(self):
		self.__RefreshServerList()

	def __OnSelectSettlementArea(self):
		# SEVER_LIST_BUG_FIX
		regionID = self.__GetRegionID()
		serverID = self.serverListOnRegionBoard.GetSelectedItem()

		serverIndex = self.__ServerIDToServerIndex(regionID, serverID)
		self.serverList.SelectItem(serverIndex)
		# END_OF_SEVER_LIST_BUG_FIX

		self.__OnSelectServer()

	def __RefreshServerList(self):
		regionID = self.__GetRegionID()

		if not serverInfo.REGION_DICT.has_key(regionID):
			return

		self.serverList.ClearItem()

		regionDict = serverInfo.REGION_DICT[regionID]

		# SEVER_LIST_BUG_FIX
		visible_index = 1
		for id, regionDataDict in regionDict.items():
			name = regionDataDict.get("name", "noname")
			try:
				server_id = serverInfo.SERVER_ID_DICT[id]
			except:
				server_id = visible_index

			self.serverList.InsertItem(id, "  %02d. %s" % (int(server_id), name))

			visible_index += 1

		# END_OF_SEVER_LIST_BUG_FIX

	def __OnSelectServer(self):
		self.__OnCloseInputDialog()
		self.__RequestServerStateList()
		self.__RefreshServerStateList()

	def __RequestServerStateList(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()

		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except:
			print "__RequestServerStateList - serverInfo.REGION_DICT(%d, %d)" % (regionID, serverID)
			return

		ServerStateChecker.Initialize()
		for id, channelDataDict in channelDict.items():
			key=channelDataDict["key"]
			ip=channelDataDict["ip"]
			udp_port=channelDataDict["udp_port"]
			ServerStateChecker.AddChannel(key, ip, udp_port)

		ServerStateChecker.Request()

	def __RefreshServerStateList(self):

		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()
		bakChannelID = self.channelList.GetSelectedItem()

		self.channelList.ClearItem()

		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except:
			print "__RequestServerStateList - serverInfo.REGION_DICT(%d, %d)" % (regionID, serverID)
			return

		for channelID, channelDataDict in channelDict.items():
			channelName = channelDataDict["name"]
			channelState = channelDataDict["state"]
			self.channelList.InsertItem(channelID, " %s %s" % (channelName, channelState))

		self.channelList.SelectItem(bakChannelID-1)
		self.__RefreshChannelBar()

	def __GetChannelName(self, regionID, selServerID, selChannelID):
		try:
			return serverInfo.REGION_DICT[regionID][selServerID]["channel"][selChannelID]["name"]
		except KeyError:
			if 9==selChannelID:
				return localeInfo.CHANNEL_PVP
			else:
				return localeInfo.CHANNEL_NORMAL % (selChannelID)

	def NotifyChannelState(self, addrKey, state):
		try:
			stateName=serverInfo.STATE_DICT[state]
		except:
			stateName=serverInfo.STATE_NONE

		regionID=int(addrKey/1000)
		serverID=int(addrKey/10) % 100
		channelID=addrKey%10

		try:
			serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["state"] = stateName
			self.__RefreshServerStateList()

		except:
			import exception
			exception.Abort(localeInfo.CHANNEL_NOT_FIND_INFO)

	def __OnClickSelectRegionButton(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()

		if (not serverInfo.REGION_DICT.has_key(regionID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_REGION)
			return

		if (not serverInfo.REGION_DICT[regionID].has_key(serverID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_SERVER)
			return

		self.__SaveChannelInfo()

		self.__RefreshServerList()
		self.__OpenServerBoard()

	def __OnClickSelectServerButton(self):
		if self.__ApplySelectedServer():
			self.__OpenLoginBoard()

	def __ApplySelectedServer(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()
		channelID = self.__GetChannelID()

		if (not serverInfo.REGION_DICT.has_key(regionID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_REGION)
			return False

		if (not serverInfo.REGION_DICT[regionID].has_key(serverID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_SERVER)
			return False

		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except KeyError:
			return False

		try:
			state = channelDict[channelID]["state"]
		except KeyError:
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_CHANNEL)
			return False

		if state == serverInfo.STATE_DICT[3]:
			self.PopupNotifyMessage(localeInfo.CHANNEL_NOTIFY_FULL)
			return False

		self.__SaveChannelInfo()

		try:
			serverName = serverInfo.REGION_DICT[regionID][serverID]["name"]
			channelName = serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["name"]
			addrKey = serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["key"]

		except:
			print "HATA __ApplySelectedServer(%d, %d, %d)" % (regionID, serverID, channelID)
			serverName = localeInfo.CHANNEL_EMPTY_SERVER
			channelName = localeInfo.CHANNEL_NORMAL % channelID

		self.__SetServerInfo("%s, %s " % (serverName, channelName))

		try:
			ip = serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["ip"]
			tcp_port = serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["tcp_port"]
		except:
			import exception
			exception.Abort("LoginWindow.__ApplySelectedServer")

		try:
			account_ip = serverInfo.REGION_AUTH_SERVER_DICT[regionID][serverID]["ip"]
			account_port = serverInfo.REGION_AUTH_SERVER_DICT[regionID][serverID]["port"]
		except:
			account_ip = 0
			account_port = 0

		try:
			markKey = regionID*1000 + serverID*10
			markAddrValue=serverInfo.MARKADDR_DICT[markKey]
			net.SetMarkServer(markAddrValue["ip"], markAddrValue["tcp_port"])
			app.SetGuildMarkPath(markAddrValue["mark"])
			# GUILD_SYMBOL
			app.SetGuildSymbolPath(markAddrValue["symbol_path"])
			# END_OF_GUILD_SYMBOL

		except:
			import exception
			exception.Abort("LoginWindow.__ApplySelectedServer")


		self.stream.SetConnectInfo(ip, tcp_port, account_ip, account_port)
		return True


	def __OnClickSelectConnectButton(self):
		self.__RefreshServerList()
		self.__OpenServerBoard()

	def __OnClickLoginButton(self):
		id = self.idEditLine.GetText()
		pwd = self.pwdEditLine.GetText()

		if len(id)==0:
			self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_ID, self.SetIDEditLineFocus)
			return

		if len(pwd)==0:
			self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_PASSWORD, self.SetPasswordEditLineFocus)
			return

		if not self.__ApplySelectedServer():
			return

		self.Connect(id, pwd)

	def OnKeyDown(self, key):
		if app.ENABLE_SAVE_ACCOUNT:
			for idx in xrange(constInfo.SAB.slotCount):
				if app.DIK_F1+idx == key and self.SAB_GetAccountData(idx):
					self.SAB_Click_Access(idx)
		return True
