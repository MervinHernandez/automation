; MUTE Xfinity - 50%
CoordMode, Mouse, Screen

;Save starting mouse position
MouseGetPos, x_start, y_start
;BlockInput, MouseMove ;block the user from moving the mouse during this operation

; DEFINE where the mute button is on the second screen
xfin_mute_x = 8136
xfin_mute_y = 1554

;-- Click above the seek bar
DllCall("SetCursorPos", "int", xfin_mute_x, "int", xfin_mute_y-350)
Sleep, 100
MouseClick, L
Sleep, 200

;-- Click the volume level at 50%
DllCall("SetCursorPos", "int", xfin_mute_x+161, "int", xfin_mute_y)
Sleep, 100
MouseClick, L
Sleep, 200

;-- CLICK Center of Screen 2
DllCall("SetCursorPos", "int", xfin_mute_x, "int", xfin_mute_y-350)
Sleep, 100
MouseClick, L
Sleep, 200

;-- PUT the Mouse Back on Screen 1
;BlockInput, Off ;and release the mouse from its bounds
MouseMove, x_start, y_start
Sleep, 100

ExitApp