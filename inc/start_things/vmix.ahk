; vMix - Start and move window position

; Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; UN-Maximize the window if it is maximized
WinRestore, %this_window%

; Move Window to Screen 1
WinMove, %this_window%,, 630, 283, 2820, 1642
;SoundBeep, 440, 500
Sleep, 500

; Move Window to Screen 2
WinMove, %this_window%,, 7271, 289, 2820, 1642
;SoundBeep, 440, 500
Sleep, 500

; Maximize Window
WinMaximize, %this_window%
SoundBeep, 440, 500
Sleep, 500

ExitApp