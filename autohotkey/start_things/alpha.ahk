; Start Sequence Alpha
CoordMode, Mouse, Screen
;{
;MouseGetPos, MouseX, MouseY
;PixelGetColor, color, %MouseX%, %MouseY%
;MsgBox The color at the current cursor position is %color%.
;ExitApp
;}

{
;MatchCol := 0x28231E
MatchCol := 0x0000FF
Loop,
{
MouseGetPos, OutputVarX, OutputVarY
PixelGetColor, OutputCol, %OutputVarX%, %OutputVarY%
If (OutputCol = MatchCol)
{
Tooltip, %OutputVarX% %OutputVarY% %OutputCol% CLICK,10,10
beep()
;// do something
ExitApp
}
else
{
Tooltip, %OutputVarX% %OutputVarY% %OutputCol%,10,10
}
Sleep, 100
}
}

; LOCK the Mouse
BlockInput, MouseMove ;block the user from moving the mouse during this operation

;1. Open Outlook
Run, C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE
Sleep, 3800
beep()

;2. Position Outlook
Runwait, D:\payload_dropbox\Dropbox\MH Docs\UTIL AutoHotkey\inc\start_things\outlook.ahk
Sleep, 500
beep()

;3. START vMix
MouseMove, 8715, 110
Sleep, 50
Run, D:\payload_dropbox\Dropbox\MH Docs\UTIL Streaming - vMix Studio\vmix_presets_2021.vmix

; = = = = = == = = = = =
;3. START 7x Windows Desktops
;Runwait, D:\payload_dropbox\Dropbox\MH Docs\UTIL AutoHotkey\inc\start_things\win_desktops_open.ahk
;Sleep, 250
;MouseClick, L, 214, 142
;Sleep, 250
;beep()

;4. Open Chromes
;Runwait, D:\payload_dropbox\Dropbox\MH Docs\UTIL AutoHotkey\inc\start_things\all_chromes.ahk
;beep()

;5. Move the last chrome
;Runwait, D:\payload_dropbox\Dropbox\MH Docs\UTIL AutoHotkey\inc\start_things\all_chromes_move.ahk
;Sleep, 500
;beep()

; = = =
; THE END
BlockInput, Off ;release the mouse
ExitApp
;= = =


; = = = = = =
; Escape to Quit anytime
~*Esc::
{
BlockInput, Off ;also release the mouse if I quit the app
ExitApp
}

; = = =
; Functions
; = = =

beep() {
SoundBeep, 1760, 300
Sleep, 300
return
}