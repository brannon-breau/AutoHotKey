/* 
; Howkey used for getting mouseclick location.
!l::
	{
		MouseGetPos &xpos, &ypos
		MsgBox "The cursor is at X" xpos " Y" ypos
	} 
	*/

	;Uncomment Hotkey and { } for troubleshooting
;!q::
;	{
		strPsScriptFile := A_ScriptDir . "\psScript.ps1"

		pdiUser := "USERNAME FOR YOU SNOW DEV LOGIN"
		pdiPass := "PASSWORD FOR YOU SNOW DEV LOGIN"

		clickLoginLocX := "1323" ;X Pos for clicking the Login button
		clickLoginLocy := "1323" ;y Pos for clicking the Login button

		clickLaunchLocX := "1323" ;X Pos for clicking the Launch PDI button
		clickLaunchLocy := "1323" ;y Pos for clicking the Launch PDI button

 
		Run "powershell.exe -NoExit -ExecutionPolicy Bypass -File " strPsScriptFile " startMessage"
		Sleep 3000

		Run "powershell.exe -ExecutionPolicy Bypass -File " strPsScriptFile " monitorOn"
		Sleep 30000

		While WinExist("ahk_exe chrome.exe")
		{
			WinClose "ahk_exe chrome.exe"
		}

		Sleep 3000

		Run "chrome.exe -incognito https://developer.servicenow.com/"
		Sleep 3000

		if WinExist("Home | ServiceNow Developers - Google Chrome")
		{
			WinActivate ; Use the window found by WinExist.
		}
		Sleep 3000

		Send "{F11}"
		Sleep 31000

		Click clickLoginLocX,clickLoginLocY
		Sleep 10000

		Send pdiUser
		Sleep 3000

		Send "{Enter}"
		Sleep 10000

		Send pdiPass
		Sleep 3000

		Send "{Enter}"
		Sleep 1800000 ; Wait 30 min to give the PDI time to wake up. should be changed if you are running dayly.

		Click clickLaunchLaunchX,clickLaunchLaunchY

		Send "{F11}"
		Sleep 10000

		While WinExist("ahk_exe chrome.exe")
		{
			WinClose "ahk_exe chrome.exe"
		}
		Sleep 5000

		Run "chrome.exe https://developer.servicenow.com/"
		Sleep 3000

		if WinExist("Home | ServiceNow Developers - Google Chrome")
		{
			WinActivate ; Use the window found by WinExist.
		}
		Sleep 3000

		Send "{F11}"
		Sleep 3000

		Run "powershell.exe -ExecutionPolicy Bypass -File " strPsScriptFile " monitorOff"
		Sleep 5000

		Run "powershell.exe -ExecutionPolicy Bypass -File " strPsScriptFile " endMessage"
		Sleep 3000

		ExitApp
	;}