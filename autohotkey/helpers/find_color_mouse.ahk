; Find a color under the mouse

; 1. GET Starting Mouse Position and color
;    MouseGetPos, MouseX, MouseY
;    PixelGetColor, color, %MouseX%, %MouseY%, RGB
;    PixelGetColor, detector, %mickey_x%, %mickey_y%, RGB
;    MsgBox Mouse coordiantes are %mickey_x% and %mickey_y% and the color is %detector%

CoordMode Mouse
CoordMode Pixel

F1::
	PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x281D31, 0, Fast RGB
	if (ErrorLevel = 0)
	{
		MouseMove x, y
		MsgBox Found the color
		MouseMove -250, 0, , R
		;Click
	}
	else if (ErrorLevel = 1)
		MsgBox it was not found,
	else if (ErrorLevel = 2)
		MsgBox there was a problem that prevented the command from conducting the search.
Return

ExitApp

; ✅ This sort of works
;PixelSearch, Px, Py, 700, 744, 1178, 1191, 0x281D31, 3, Fast
;if ErrorLevel
;    MsgBox, That color was not found in the specified region.
;else
;    MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
; = = Functions
Esc::
{
Exit App
}