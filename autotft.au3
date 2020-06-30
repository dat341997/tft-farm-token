#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\tft.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Made by m1nt.
#AutoIt3Wrapper_Res_ProductName=TFT Auto BOT
#AutoIt3Wrapper_Res_ProductVersion=1.0.0
#AutoIt3Wrapper_Res_CompanyName=Nguyen Huu Minh
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Nguyen Huu Minh

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

;THIS IS FOR CODE
;Mouse click delay----------------------------
Opt ("MouseClickDelay", 5)
Opt ("MouseClickDownDelay", 200)

;Main part-------------------------------------
Global $clientsz = WinGetClientSize("League of Legends") ;get the client width and height
Global $ffat15 = 1
Func autobot()
	WinActivate("League of Legends")
	While not WinExists("League of Legends (TM) Client")
		sleep(1500)
		ControlClick("League of Legends", "", "[Classnn:Chrome_RenderWidgetHostHWND1]", "left", 1, Round(0.5*$clientsz[0]), Round(0.943*$clientsz[1]))
		sleep(1000)
		ControlClick("League of Legends", "", "[Classnn:Chrome_RenderWidgetHostHWND1]", "left", 1, Round(0.419*$clientsz[0]), Round(0.9541*$clientsz[1]))
		sleep(Round(Random(2,4)*1000)) ;click the matchmaking button every 3-5sec the time is chose ramdomly between 3-5s
		ControlClick("League of Legends", "", "[Classnn:Chrome_RenderWidgetHostHWND1]", "left", 1, Round(0.5*$clientsz[0]), Round(0.775*$clientsz[1]))
	WEnd
	WinWait("League of Legends (TM) Client")
	sleep(15000) ;wait for the game to exists
	WinActivate("League of Legends (TM) Client")
	sleep(3000)
	Local $gamesz = WinGetClientSize("League of Legends (TM) Client")
	Local $pxdifference[2] = [Round((@DesktopWidth-$gamesz[0])/2), Round((@DesktopHeight-$gamesz[1])/2)]
	Local $topmiddle[2] = [@DesktopWidth/2, ($pxdifference[1] + 3)]
	Local $pxchecksum = PixelChecksum($topmiddle[0] - 5, $topmiddle[1] + 5, $topmiddle[0] + 5, $topmiddle[1] + 10)
	Local $coordinatesSurrender[2] = [989,519]
	While $pxchecksum = PixelChecksum($topmiddle[0] - 5, $topmiddle[1] + 5, $topmiddle[0] + 5, $topmiddle[1] + 10)
		sleep(7000) ;every 7 sec check if the game is ready
	WEnd
	Local $timer = TimerInit()
	sleep(59000)
	While TimerDiff($timer) <= 620000
		For $i = 1 To Random(1, 2, 1)
			MouseClick("left", ($pxdifference[0] + $gamesz[0] * (0.3 + (0.105 * Random(0, 4, 1)))), Round(($gamesz[1] * 0.92) + $pxdifference[1]), 1, 10)
			sleep(Round(Random(1,2,0) * 1000))
		Next
		;MouseClick("right", ($pxdifference[0] + Round($gamesz[0] * (Random(30,40,1) + (20 * Random(0,1,1))))), $pxdifference[1] + Round($gamesz[1] * Random(31,34,0)), 1, 25) =====>   UNKNOWN ERROR
		If TimerDiff($timer) >= 300000 Then
			MouseClick("left", ($pxdifference[0] + Round($gamesz[0] * 0.1914)), ($pxdifference[1] + Round($gamesz[1] * 0.893)), 2, 10)
		EndIf
		sleep(45000) ;do something every 45 sec
	WEnd
	If $ffat15 = 1 Then
		Send("{ENTER}")
		sleep(500)
		Send("/")
		sleep(300)
		send("f")
		sleep(200)
		send("f")
		sleep(500)
		Send("{ENTER}")
		sleep(500)
		MouseClick("left", $coordinatesSurrender[0], $coordinatesSurrender[1], 1, 10)
	EndIf
	WinWaitClose("League of Legends (TM) Client")
	sleep(10000)
EndFunc

;THIS IS FOR GUI
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\users\microsoft windows\desktop\project tft bot\form1.kxf
$Form1_1 = GUICreate("TFT Auto Bot", 350, 177, -1, -1)
GUISetIcon("C:\Users\Microsoft Windows\Desktop\tft.ico", -1)
$Label1 = GUICtrlCreateLabel("Works with any resolution. Change your game to windowed borderless.", 8, 152, 337, 17)
$Label2 = GUICtrlCreateLabel("Current Resolution:", 8, 136, 94, 17)
$Label3 = GUICtrlCreateLabel(@DesktopWidth & " x " & @DesktopHeight, 104, 136, 136, 17)
$Button1 = GUICtrlCreateButton("Start", 128, 16, 97, 35)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
$Group1 = GUICtrlCreateGroup("Surrender at 15 minutes", 16, 64, 313, 65)
$Checkbox1 = GUICtrlCreateCheckbox("FF at 15min", 224, 88, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Label4 = GUICtrlCreateLabel("Do not tick/untick this checkbox", 40, 88, 159, 17)
$Label5 = GUICtrlCreateLabel("while the script is running.", 40, 104, 125, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			ExitLoop
			GUIDelete($Form1_1)
			Exit
		Case $Button1 ;=====> THE START BUTTON
			If not _IsChecked($Checkbox1) Then
				Global $ffat15 = 0
			EndIf
			While 1
				autobot()
			WEnd
	EndSwitch
WEnd

