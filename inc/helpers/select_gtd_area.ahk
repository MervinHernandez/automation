; SELECT Area of Life
; - from a list of GTD areas in nested dropdown lists

Gui, Add, Text, x12 y9 w160 h20 , GTD Area of Life Selector
Gui, Add, DropDownList, x12 y39 w160, Personal|Work
Gui, Add, DropDownList, x12 y69 w160, DropDownList
Gui, Add, DropDownList, x12 y99 w160, DropDownList
; Generated using SmartGUI Creator 4.0
Gui, Show, x239 y152 h141 w300, New GUI Window
Return

GuiClose:
ExitApp