; Accounting - Entering Receipts

; 2. Generate GUI Elements
Gui, Add, Text, x22 y39 w110 h80 , Enter the following information for the name of the receipt.
Gui, Add, Edit, x142 y69 w110 h20 vDate, Date
Gui, Add, Edit, x142 y99 w50 h20 vDollars, Amount
Gui, Add, Edit, x202 y99 w50 h20 vCents, Cents
Gui, Add, Button, x12 y159 w80 h30 , OK
Gui, Add, Button, x102 y159 w80 h30 , Cancel
Gui, Add, Edit, x142 y39 w110 h20 , VEndor
; Generated using SmartGUI Creator 4.0
Gui, Show, x279 y217 h292 w289, Accounting - Enter Receipts

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
