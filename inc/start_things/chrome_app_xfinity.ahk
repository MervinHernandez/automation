; Start Xfinity TV
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

;Save starting mouse position
MouseGetPos, x_start, y_start

{
;-- Progress Bar --
Progress, b w200, Working ..., Starting XFinity, CNN
Progress, 10
;-- Progress Bar --

; Run Google Chrome - CNN app
RunWait, "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe"  --profile-directory=Default --app-id=fnglgblddmjfkkfnfcncbkjjgilhgokl
Sleep, 1500
Progress, 25

; Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Move Window to Screen 1
WinMove, %this_window%,, 630, 283, 2820, 1642
Sleep, 850
Progress, 35

; Move Window to Screen 2
WinMove, %this_window%,, 7271, 289, 2820, 1642
Sleep, 850
Progress, 40

; Maximize Window
WinMaximize, A

; Call Screen 2 Duplicator
RunWait, %A_ScriptDir%\..\helpers\do_screen2_allmon.ahk
Sleep, 800
Progress, 50

; Click to exit Win-Tab
MouseClick, L
Progress, 75
Sleep, 2000
Progress, 78
Sleep, 2000
Progress, 81
Sleep, 2000
Progress, 85
Sleep, 9000 ;9 seconds

; Set Volume and close flyout menu
;-- Click above the seek bar
BlockInput, MouseMove ;block the user from moving the mouse during this operation
DllCall("SetCursorPos", "int", 9523, "int", 1605)
MouseClick, L
Sleep, 250
;-- Click the volume level at 50%
DllCall("SetCursorPos", "int", 9700, "int", 1811)
Sleep, 100
MouseClick, L
Sleep, 250
;-- Click the "x" to close the security bar above the video
DllCall("SetCursorPos", "int", 6755, "int", 86)
MouseClick, L
Sleep, 250
BlockInput, Off ;and release the mouse from its bounds
Progress, 90

; PLAY Sound
SoundPlay, %A_ScriptDir%\..\sounds\airplane_chime.mp3
Sleep, 2500

; PUT mouse back where it started
MouseMove, x_start, y_start
BlockInput, Off ;and release the mouse from its bounds
Sleep, 800

}
ExitApp

; = = = = = =
; Escape to Quit anytime
~*Esc::
{
BlockInput, Off ;also release the mouse if I quit the app
ExitApp
}