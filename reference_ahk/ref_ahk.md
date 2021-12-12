# AutoHotkey - Quick Reference

## Progress Bar
`ref_ahk/progress_bar.ahk`
Display progress bar on screen.

## File Locations
`A_Script` = the file path location for this script

## Referencing Files
The following example is a script playing a sound that is located in the same folder where this script running is located. 
```markdown
SoundPlay, %A_ScriptDir%\.\sounds\airline_ding.mp3
```
