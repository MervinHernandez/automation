; START - Chrome App - YouTube
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

;Save starting mouse position
MouseGetPos, x_start, y_start

; Run Google Chrome - YouTube App
RunWait, "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe"  --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml
Sleep, 500
; Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Move Window to Screen 1
WinMove, %this_window%,, 630, 283, 2820, 1642
Sleep, 850

; Move Window to Screen 2
WinMove, %this_window%,, 7271, 289, 2820, 1642
Sleep, 850

; Maximize Window
WinMaximize, A

; Call Screen 2 Duplicator
RunWait, %A_ScriptDir%\..\helpers\do_screen2_allmon.ahk
Sleep, 700

; PLAY Sound
SoundPlay, %A_ScriptDir%\..\sounds\airplane_chime.mp3

; PUT mouse back where it started
MouseMove, x_start, y_start
Sleep, 800

ExitApp