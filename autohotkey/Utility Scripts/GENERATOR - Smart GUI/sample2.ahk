Gui, Add, Edit, x157 y8 w100 h20 vDate, Date
Gui, Add, Edit, x157 y38 w100 h20 vAmount, Amount
Gui, Add, Button, x22 y99 w70 h20 , OK
Gui, Add, Button, x102 y99 w70 h20 , Cancel
Gui, Add, Text, x32 y9 w100 h50 , Enter the following information for the name of the receipt.
Gui, Add, Edit, x162 y69 w100 h20 , Amount
; Generated using SmartGUI Creator 4.0
Gui, Show, x279 y217 h173 w285, New GUI Window
Return

GuiClose:
ExitApp