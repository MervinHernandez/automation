#SingleInstance, Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

Gui, -Caption +AlwaysOnTop ToolWindow
Gui, Margin, 0, 0
Gui, Add, Button, vButton1 gBtn, Select 1
Gui, Add, Button, vButton2 gBtn x+5 yp, Select 2
SetTimer, IfNoteP_Active, 100

IfNoteP_Active:
If (note_hwnd := WinActive("ahk_class Notepad")) {
	;SetTimer, %A_ThisLabel%, Off
	WinGetActiveStats, nTitle, N_W, N_H, N_X, N_Y
	Gui_Show(N_X+200, N_Y+5)
	SetTimer, IfNoteP_Move, 100
}
Return

IfNoteP_Move:
If !(note_hwnd := WinActive("ahk_class Notepad")) {
	SetTimer, %A_ThisLabel%, Off
	Gui_Show("hide")
	SetTimer, IfNoteP_Active, 100
	Return
}

WinGetActiveStats, nTitle, N_W, N_H, N_X, N_Y
If (N_X <> Last_NX || N_Y <> Last_NY) {
	Gui_Show(N_X+200, N_Y+5)
	Last_NX := N_X, Last_NY := N_Y
}
Return

Gui_Show(X, Y="") {
	If InStr(X, "hide")
		Gui, Hide
	Else
		Gui, Show, NoActivate x%X% y%Y%, MyGuiWin
	Return
}

Btn:
return
