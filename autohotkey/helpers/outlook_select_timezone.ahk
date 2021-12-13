; Outlook
; This script selects the timezone from the dropdown menu
; faster than I can navigate to it

; IF - MS Outlook
if WinActive("ahk_exe OUTLOOK.EXE")
{
    ; How many times do we need to scroll down, to select a timezone
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