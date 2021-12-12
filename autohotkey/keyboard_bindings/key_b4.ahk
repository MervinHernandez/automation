;Key B4

;MsgBox, Key B4

{
; Accounting - Save Receipt
; = = = =
; This script makes it faster to save the receipt (PDF) file presently inview
; with the correct file name Mervin wants.
; The desired file name format is {date of the receipt} - {vendor_name} - {amount} .pdf

; 1. GUI Window Position, Dimensions, Title
Gui, Show, x1143 y750 h200 w285, Accounting - Enter Receipts

; 2. Generate GUI Elements
Gui, Add, Text, x22 y39 w110 h80 , Enter the following information for the name of the receipt.
Gui, Add, Edit, x142 y39 w110 h20 vVendor, Vendor
Gui, Add, Edit, x142 y69 w110 h20 vDate, 2021-
Gui, Add, Edit, x142 y99 w50 h20 vDollars, Amount
Gui, Add, Edit, x202 y99 w50 h20 vCents, Cents
Gui, Add, Button, x12 y159 w80 h30 , OK
Gui, Add, Button, x102 y159 w80 h30 , Cancel
Return

; 3. Actions
; 3.1 Do Things
ButtonOk:
Gui, submit
{
receiptNAME = %Date%-%Vendor%-%Dollars%_%Cents%
clipboard := receiptNAME
}
MsgBox The file name:`n`n%clipboard% `n`n is in your clipboard now. You can paste with Ctrl-V
ExitApp

; 3.2 Close
ButtonCancel:
GuiClose:
ExitApp
}

Exit