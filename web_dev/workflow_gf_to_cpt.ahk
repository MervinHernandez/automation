; Workflow - Gravity Forms to CPT
; This script brings field data from a spreadsheet, to populate various
; fields in Gravity Forms to associate an input with a CPT meta.


; 0. Clear all the things
global field_value := ""
clipboard := ""

{
; Step 1 - Gather Data from Spreadsheet
step1()
beep()

; Step 2 - Switch to other Chrome Window
step2()
beep()

; Step 3 - Populate fields in Gravity Form
step3()
beep()

; Step 4 - Manual
step4()
beep()
Sleep, 300
MsgBox, Your Turn

; Step 5 - Note that this field is done
step2()
;step5()
Sleep, 300
ExitApp
}

return

; = = =
Esc::
ExitApp
;= = =

; = = =
; Functions
; = = =
beep() {
SoundBeep, 1750, 250
Sleep, 250
return
}

step1() {
;SELECT Next Record
    Send {Blind}{Down} ;move down a row
    Sleep 10
    Send {Blind}{Left} ;move left one cell
    Sleep 10

;SAVE Field to Variable
    {
    ;EMPTY the clipboard
        clipboard := ""
        Sleep 180
    ;SEND copy command
        Send ^c
        ClipWait  ; Wait for the clipboard to contain text.
    ;SAVE the text copied into a variable
        global field_value := trim(clipboard)
        Sleep 250
    }
;MARK this row as working
    Send {Right}
    Send Working ...
    Sleep 300
    Send {Left}
    Sleep 300
return
}

step2() {
Send, {Blind}{Alt Down}{Tab}{Alt Up}
Sleep, 250
return
}

step3() {
; Past Clipboard
Send, META %field_value%

; Paste
;Send, {Blind}{Ctrl Down}v{Ctrl Up}{Enter}

; Navigate to the Custom Field Name by pressing tab "x" times
Loop, 6 {
Send, {Tab}
Sleep, 200
}

; Set the Custom Field Name to be "New"
Send, {Right}
Sleep, 200
Send, {Tab}
Sleep, 100

; Past the field value again
Send, %field_value%

return
}

step4() {
Loop, 3
    {
    Send, {Blind}{Tab}
    Sleep, 50
    }
Send, {Blind}{Ctrl Down}{a}{Ctrl Up}
Send, {Delete}
return
}

step5() {
Send, {Right}
Send, Done
Send, {Up}
Sleep, 300
Send, {Down}
}