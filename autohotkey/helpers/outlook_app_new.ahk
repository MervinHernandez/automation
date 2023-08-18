; OUTLOOK - New Appointment Window
Run, "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /c ipm.appointment
Sleep, 250

if WinExist("Untitled - Appointment")
    WinActivate ; Use the window found by WinExist.
else
    ; nothing
Exit