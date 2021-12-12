; [WIP] FIND Latest Downloaded File
Loop, C:\Users\mervi\Downloads\*
    ; create a list of those files consisting of the time the file was modified und the file name separated by tab
    Filelist = %Filelist%%A_LoopFileTimeModified%`t%A_LoopFileName%`n
    ; sort the list by time modified in reverse order
    Sort, Filelist, R

    Loop, parse, Filelist, `n,`r
        {
        if A_LoopField =
        continue
        ; Split the list items into two parts at the tab character
        StringSplit, FileItem, A_LoopField, %A_Tab%
        ; open only the most-recently modified file
            latest_file = C:\Users\mervi\Downloads\%FileItem2%
                break    ; terminate the loop
        }
MsgBox, 0, Latest File, %latest_file%

return