;Key B2

;MsgBox, Key B2

;Run, %A_ScriptDir%\workflows\accounting_receipts.ahk

; IF - MS Outlook
if WinActive("ahk_exe OUTLOOK.EXE")
{
    ; Pacific Time = 9 times
    ; Mountain Time = 12 times
    ; Central Time = 15 times
    ; Eastern Time = 21 times
    Send {Home}
    Loop, 15
    {
    Send {Down}
    }
}



;Close App
Exit