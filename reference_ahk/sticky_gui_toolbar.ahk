DetectHiddenWindows, On

WinWait, ahk_class Notepad,,1
Gui, Destroy
Gui, Color, ffffff
Loop
{
	;IniRead, outputvar, filename, section, key, default
	IniRead, Name%A_Index%, toolbar.ini, Tools, Name%A_Index%, 0
	IniRead, Script%A_Index%, toolbar.ini, Tools, Script%A_Index%, 0

	IniName := Name%A_Index%
	IniScript%A_Index% := Script%A_Index%

	if IniName = 0
	{
		break
	}
	Gui, Add, Button, gButton vIniScript%A_Index%, %IniName%
}

SetTimer, ShowGui, 1

ShowGui:
	WinGetPos, X, Y, W, H, ahk_class Notepad
	;X := X - 130 ;left side
	X := X + W ;right side
	Y := Y + 5
	W := 120
	H := H - 35

	IfWinNotExist, ahk_class Notepad
	{
		Gui, Destroy
		return
	}

	Gui, +Owner +Border +ToolWindow
	Gui, Show, NoActivate x%X% y%Y% w%W% h%H%, Toolbar
return

Button:
	Command := %A_GuiControl%
	WinActivate ahk_class Notepad
	SendInput, %Command% {ENTER}
return