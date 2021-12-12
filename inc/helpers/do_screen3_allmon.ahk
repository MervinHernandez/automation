; Screen 3 > Window 1 > Duplicate to all monitors

; 1.1 Press Win+Tab
Send, {Blind}{LWin Down}{Tab}{LWin Up}

; 1.2 Move mouse to third screen
DllCall("SetCursorPos", "int", 10335, "int", 385)
Sleep 600

; 1.3 Right Click menu on first window
MouseClick, R
Sleep 600

; 1.4 Click to duplicate on all windows
DllCall("SetCursorPos", "int", 10475, "int", 589)
Sleep 600
MouseClick, L

ExitApp