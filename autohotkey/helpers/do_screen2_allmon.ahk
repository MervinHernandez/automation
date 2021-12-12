; Screen 2 > Window 1 > Duplicate to all monitors
CoordMode, Mouse, Screen
; Save starting mouse position
MouseGetPos, x_start, y_start

; 1.1 Press Win+Tab
Send, {Blind}{LWin Down}{Tab}{LWin Up}

; 1.2 Move mouse to second screen
BlockInput, MouseMove ;block the user from moving the mouse during this operation
DllCall("SetCursorPos", "int", 7258, "int", 509)
Sleep 500

; 1.3 Right Click menu on first window
MouseClick, R
Sleep 500

; 1.4 Click to duplicate on all windows
;DllCall("SetCursorPos", "int", 7341, "int", 702)
Send {Down}
Sleep 80
Send {Down}
Sleep 80
Send {Down}
Sleep 80
Send {Enter}
Sleep 500
MouseClick, L

; Put the mouse back
MouseMove, x_start, y_start
Sleep, 250
Send, {Blind}{Esc}
BlockInput, Off ;and release the mouse from its bounds

ExitApp