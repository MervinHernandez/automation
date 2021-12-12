Gui, Add, Edit, x157 y8 w100 h20 vDate, Date
Gui, Add, Edit, x157 y38 w100 h20 vAmount, Amount
Gui, Add, Button, x27 y68 w70 h20 , OK
Gui, Add, Button, x177 y68 w70 h20 , Cancel
Gui, Add, Text, x32 y9 w100 h50 , Enter the following information for the name of the receipt.
; Generated using SmartGUI Creator 4.0
Gui, Show, x279 y217 h102 w281, New GUI Window
Return

GuiClose:
ExitApp