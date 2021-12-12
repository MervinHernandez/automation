; MOVE three chrome windows to three desktops

; Win-Tab
Send, {Blind}{LWin Down}{Tab}{LWin Up}
Sleep, 800

; Drag Chrome 3 to Desktop 3
MouseClick, L, 393, 419,,, D
Sleep, 336
MouseClick, L, 830, 69,,, U
Sleep, 343

; Drag Chrome 2 to Desktop 2
MouseClick, L, 547, 386,,, D
Sleep, 336
MouseClick, L, 555, 94,,, U
Sleep, 343

; Click Desktop 1
MouseClick, L, 418, 406

ExitApp