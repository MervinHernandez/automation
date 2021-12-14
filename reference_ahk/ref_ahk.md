# AutoHotkey - Quick Reference

# Demo Files (available in this folder)
## Progress Bar
`ref_ahk/progress_bar.ahk`
Display progress bar on screen.

## Progress bar with image
```text
if FileExist("C:\WINDOWS\system32\ntimage.gif")
    SplashImage, %A_WinDir%\system32\ntimage.gif, A,,, Installation
Loop, %A_WinDir%\system32\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Installing..., Draft Installation
    Sleep, 50
    if (A_Index = 100)
        break
}
```

## Sticky GUI buttons
`sticky_gui_buttons.ahk`

# AHK Reference
## File Locations
`A_Script` = the file path location for this script

## Referencing Files
The following example is a script playing a sound that is located in the same folder where this script running is located. 
```markdown
SoundPlay, %A_ScriptDir%\.\sounds\airline_ding.mp3
```

# Misc Reference Examples
## Find Color Under Mouse
```text
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
MsgBox The color at the current cursor position is %color%.
return
```

## LOOP to find the color under the mouse continuously
```text
MatchCol := 0x0000FF
Loop,
{
MouseGetPos, OutputVarX, OutputVarY
PixelGetColor, OutputCol, %OutputVarX%, %OutputVarY%
If (OutputCol = MatchCol)
{
Tooltip, %OutputVarX% %OutputVarY% %OutputCol% CLICK,10,10
beep()
}
else
{
Tooltip, %OutputVarX% %OutputVarY% %OutputCol%,10,10
}
Sleep, 100
}
```

## GUI - Change Icon
```text
{
; https://autohotkey.com/board/topic/10300-setting-gui-icons-dynamically-taskbar-and-alttab-list/#entry65044

Gui, Add, Button,, Change Icon
Gui, Show
return

ButtonChangeIcon:
hIcon := DllCall("LoadImage", uint, 0, str, A_ScriptDir "\icon1.ico"
	, uint, 1, int, 0, int, 0, uint, 0x10)  ; Type, Width, Height, Flags
Gui +LastFound  ; Set the "last found window" for use in the next lines.
SendMessage, 0x80, 0, hIcon  ; Set the window's small icon (0x80 is WM_SETICON).
SendMessage, 0x80, 1, hIcon  ; Set the window's big icon to the same one.
return

GuiClose:
DllCall("DestroyIcon", "ptr", hIcon)
ExitApp
}
```

## Loop Thru Files in Folder - Method 1
```text
{
FileList := ""  ; Initialize to be blank.
Loop, D:\payload_dropbox\Dropbox\MH Docs\UTIL Shortcuts\TASKBAR Shortcuts\*.vnc*
    FileList .= A_LoopFileName "`n"
Sort, FileList, R  ; The R option sorts in reverse order. See Sort for other options.
Loop, parse, FileList, `n
{
    if (A_LoopField = "")  ; Ignore the blank item at the end of the list.
        continue
    MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    IfMsgBox, No
        break
}
}
```

## PUT The Mouse Back where it started
```text
{
; Prerequisite
CoordMode, Mouse, Screen

; Save starting mouse position
MouseGetPos, x_start, y_start

; Put the mouse back
MouseMove, x_start, y_start
}
```

## CLIPBOARD Set and Paste
```text
{
clipboard = C:\Users\mervi\Downloads\calendards_export.csv
Send, ^v
}
```

## LIST of Folder Contents
```text
; Create the ListView with two columns, Name and Size:
Gui, Add, ListView, r20 w700 gMyListView, Name|Size (KB)

; Gather a list of file names from a folder and put them into the ListView:
Loop, %A_MyDocuments%\*.*
    LV_Add("", A_LoopFileName, A_LoopFileSizeKB)

LV_ModifyCol()  ; Auto-size each column to fit its contents.
LV_ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Show
return

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp
```

## CONDITIONAL - Window Title (Method 1)
```text
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
MsgBox, True
}
else {
MsgBox, False
}
```

## CONDITIONAL - Window Title (Method 2)
```text
WinActivate, ahk_class rctrl_renwnd32
WinGetTitle, Title, A

if Title contains Appointment
{
msgbox, yes it contains %Title%
}
else
{
msgbox, no it contains %Title%
}
```

## Loop thru all windows and show id and title
```text
WinGet, id, List,,, Program Manager
Loop, %id%
{
    this_id := id%A_Index%
    WinActivate, ahk_id %this_id%
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%
    MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
    IfMsgBox, NO, break
}
```

## WINDOW - with text prompts
```text
Gui, Font, underline
Gui, Add, Text, cBlue gLaunchGoogle, Click here to launch Google.

; Alternatively, Link controls can be used:
Gui, Add, Link,, Click <a href="www.google.com">here</a> to launch Google.
Gui, Font, norm
Gui, Show
return

LaunchGoogle:
Run www.google.com
return
```

## Working Directory Operations
```text
;Method 1
    ;Local script folder reference
    Run, %A_ScriptDir%\start_things\outlook_do_appt.ahk

;Method 2
    ;1. Set working directory to be the parent of this script
    SetWorkingDir, %A_ScriptDir%\..
    ;2. Play sound from a folder within the working directory
    SoundPlay, %A_WorkingDir%\sounds\airline_ding.mp3

;Method 3
    ; Call the parent directory, and then browse within, again
    SoundPlay, %A_ScriptDir%\..\sounds\airline_ding.mp3
```

## Microsoft Oulook direct windows calls
```text
; Windows Key + z
; -- Miscrosoft Office > Open New Email
#z:: Run, "%programfiles%\Microsoft Office\root\Office16\OUTLOOK.EXE" /c ipm.note

; Windows Key + x
; -- Miscrosoft Office > Open New Calendar Appointment
#x:: Run, "%programfiles%\Microsoft Office\root\Office16\OUTLOOK.EXE" /c ipm.appointment

; Windows Key + c
; -- Miscrosoft Office > Open New Email
#c:: Run, "%programfiles%\Microsoft Office\root\Office16\OUTLOOK.EXE" /c ipm.task
```

## Show a splash screen of text
```text
SplashTextOn,,, A message box is about to appear.
Sleep 3000
SplashTextOff
MsgBox The backup process has completed.
```