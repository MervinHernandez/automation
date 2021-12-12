; Outlook - Export Calendar to CSV
; = = =
; This script makes it very easy to select the respective menu options to spit out
; a calendar export for analysis.

; PRE-REQUISITE
; This script must be run with focus on the calendar window
; of Microsoft Outlook

; 1. Open File > Export
Send, {Blind}{Alt Down}f{Alt Up}
Sleep, 200
Send, {Blind}o
Sleep, 200
Send, {Blind]i
Sleep, 200

; Pause
Sleep, 1000

; 2. Select Export to File
Send, {Blind}{Up}
Sleep, 200
Send, {Blind}{Enter}

; Pause
Sleep, 1000

; 3. Select CSV Format
Send, {Blind}{Enter}

; Pause
Sleep, 1000

; 4. Select default Calendar
Send, {Blind}{Enter}

; Pause
Sleep, 1000

; 5. Set Save Destination (via clipboard)
clipboard = C:\Users\mervi\Downloads\calendards_export.csv
Send, ^v
Sleep, 400
Send, {Blind}{Enter}

; Pause
Sleep, 1000

; 6. Select "Export Appointments"
Send, {Blind}{Enter}

Exit

; = = = = = =
; Escape to Quit anytime
~*Esc:: ExitApp