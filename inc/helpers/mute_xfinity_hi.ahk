; MUTE Xfinity - 50%
CoordMode, Mouse, Screen

;Save starting mouse position
MouseGetPos, x_start, y_start
;BlockInput, MouseMove ;block the user from moving the mouse during this operation

;-- Click above the seek bar
DllCall("SetCursorPos", "int", 9523, "int", 1605)
Sleep, 100
MouseClick, L
Sleep, 500

;-- Click the volume level at 50%
DllCall("SetCursorPos", "int", 9735, "int", 1811)
Sleep, 100
MouseClick, L
Sleep, 500

;-- CLICK Center of Screen 2
DllCall("SetCursorPos", "int", 8377, "int", 968)
Sleep, 100
MouseClick, L
Sleep, 500

;-- PUT the Mouse Back on Screen 1
;BlockInput, Off ;and release the mouse from its bounds
MouseMove, x_start, y_start
Sleep, 600

Exit