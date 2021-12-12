; Accounting - Entering Receipts

; 2. Generate GUI Elements
Gui, Add, Text, x32 y9 w100 h50 , Enter the following information for the name of the receipt.
Gui, Add, Edit, x157 y8 w100 h20 vDate, Date
Gui, Add, Edit, x157 y38 w100 h20 vDollars, Amount
Gui, Add, Edit, x157 y69 w100 h20 vCents, Cents
Gui, Add, Button, x22 y99 w70 h20 , OK
Gui, Add, Button, x102 y99 w70 h20 , Cancel


; 1. GUI Window Position, Dimensions, Title
Gui, Show, x279 y217 h173 w285, Accounting - Enter Receipts

Return

ButtonCancel:
GuiClose:
ExitApp

ButtonOk:
Gui, submit
{
receiptNAME = %Date%-Uber-%Dollars%_%Cents%
clipboard := receiptNAME
}
MsgBox Control-C copied the following contents to the clipboard:`n`n%clipboard%

ExitApp
