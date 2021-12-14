; Outlook - Helper Buttons
; These are meant to make it faster to punch in a time zone and other quick functions.

CoordMode, Mouse, Window
SetTitleMatchMode, 2 ; Title must contain
#SingleInstance, Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

Gui, -Caption +AlwaysOnTop ToolWindow
Gui, Margin, 0, 0
Gui, Add, Button, vButton1 gBtn, Central Time
Gui, Add, Button, vButton2 gBtn2 x+5 yp, Eastern Time
;Gui, Add, Button, vButton3 gBtn3 x+15 yp, Close
SetTimer, IfNoteP_Active, 100

IfNoteP_Active:
If (note_hwnd := WinActive("- Appointment")) {
	;SetTimer, %A_ThisLabel%, Off
	WinGetActiveStats, nTitle, N_W, N_H, N_X, N_Y
	Gui_Show(N_X+50, N_Y+310)
	SetTimer, IfNoteP_Move, 100
}
Return

IfNoteP_Move:
If !(note_hwnd := WinActive("- Appointment")) {
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
{
; 1. Move mouse and click Start Time Zone
    MouseMove, 846, 477, 2
    Sleep, 200
    MouseClick, L
    Sleep, 50
    MouseClick, L
;2. Select Time Zone by going
    ; Pacific Time = 9 times
    ; Mountain Time = 12 times
    ; Central Time = 15 times
    ; Eastern Time = 21 times
    Send {Home}
    Loop, 15
    {
    Send {Down}
    }
Sleep, 500
return
}
Btn2:
{
; 1. Move mouse and click Start Time Zone
    MouseMove, 846, 477, 2
    Sleep, 200
    MouseClick, L
    Sleep, 50
    MouseClick, L
;2. Select Time Zone by going
    ; Pacific Time = 9 times
    ; Mountain Time = 12 times
    ; Central Time = 15 times
    ; Eastern Time = 21 times
    Send {Home}
    Loop, 21
    {
    Send {Down}
    }
Sleep, 500
return
}
    Btn3:
    {
    ExitApp
    }
