; Gravity Form - Fill In Test
; = = = = = = = = = =
; PREREQUISIT
; 1. Spreadsheet (chrom window) open on the left side of the screen with
;    - each COLUMN is a test form submission.
; 2. Browser window (Edge) open on the right side of the screen, with
;    - the cursor ready to populate the first form field.
; 3. Special Situations
;    - The column containing all of the field values to enter, must also contain
;      sequential operations like "next page", in the form of "ENTER", in the order
;      in which it must occur.

; 1. GRAB contents of field to populate
Send, {Blind}{Ctrl Down}c{Ctrl Up}
this_field = %clipboard%
Sleep, 171

; 2. Switch windows to the form
Send, {Alt Down}{Tab}{Alt Up}
Sleep, 171

; 3. CHECK for certain conditions
{
    ; 3.1 Radio Button
    IF Clipboard contains Radio
        {
            radio_entry()
            return
        }
    ; 3.2 Tab required ?
    IF Clipboard contains TAB
        {
            Send, {Tab}
            return
        }
    ; 3.3 Next Page / Enter
    IF Clipboard contains ENTER
        {
            Send, {Enter}
            Sleep, 2500
            return
        }
    else
        {
            drop_it()
            return
        }
}
; = = = = = =
; FUNCTIONS
; = = = = = =
drop_it() {
    ; Paste Contents
    Send, {Blind}{Ctrl Down}v{Ctrl Up}
    ; Tab to next field
    Send, {Tab}
}

radio_entry() {
; Radio Button - Click Yes or No
    IF Clipboard contains yes
    {
        ; Press first option
        Send, {Space}
        Send, {Tab}
    }
    else
    {
        ; Press second option
        Send, {Down}
        Send, {Tab}
    }
}
