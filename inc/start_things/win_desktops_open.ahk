;OPEN Multiple Desktop windows
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

; Set time between clicks
hold_for = 200

; Open Task View
MouseClick, L, 132, 2118
Sleep, 700

; Add Desktop
MouseClick, L, 177, 97
Sleep, %hold_for%

; Add Desktop 2
MouseClick, L, 807, 119
Sleep, %hold_for%

; Add Desktop 3
MouseClick, L, 1143, 126
Sleep, %hold_for%

; Add Desktop 4
MouseClick, L, 1451, 146
Sleep, %hold_for%

; Add Desktop 5
MouseClick, L, 1706, 152
Sleep, %hold_for%

; Add Desktop 6
MouseClick, L, 1994, 152
Sleep, %hold_for%

; Add Desktop 7
MouseClick, L, 2272, 153
Sleep, %hold_for%

; Done
ExitApp

; = = = = = =
; Escape to Quit anytime
~*Esc:: ExitApp