; Windows - get the filepath to the last downlaoded file in Downloads
Directory := "C:\\Users\\mervi\\Downloads"
Directory := "C:\\Users\\mervi\\OneDrive - Mervin Enterprises\\Documents\\UTIL ShareX\\Screenshots\\2023-09"
Newest := 0
NewestFile := ""
loop,%Directory%\\*.* ;loop through all files in directory checking for newest
{
    if (A_LoopFileTimeCreated > Newest) { ;if this file is newer continue
        Newest := A_LoopFileTimeCreated ;reset variable to higher value
        NewestFile := A_LoopFileLongPath ;reset varaible to newest file
    }
}
clipboard := NewestFile ;copy the newest file path to clipboard
Exit