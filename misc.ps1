######## LAB ######
#1. list all files under c windows drive and its subfolders
dir c:\netcheck  -Recurse -Filter '*.txt'

#list directories under the directories
dir C:\netcheck -Directory -recurse
$fsize = dir C:\Netcheck -Recurse -Filter '*.pdf' | Measure-Object length -Sum
"{0:N2}" -f ($fsize.sum / 1MB) + " MB"

"{0:N2}" -f ($fsize.Sum/1mb) + " MB"

#2. Repeat and measure how many txt files and their total size
dir c:\work  -Recurse -Filter '*.txt' | Measure-Object -Sum

#3 get process and count and sort by company name
#REMEMBER TO FIND OUT MORE ABOUT A CMDLET DO "GET-MEMBER"
Get-Process | gm #Not you know what properties you can use

$proc = Get-Process | select id, name, WorkingSet, StartTime | Format-Table
$proc | order by starttime 

$proc.GetEnumerator() | where {$_.starttime -isnot 'null'}

Get-Process | gm


Get-ChildItem C:\Windows -Recurse| Measure-Object -Property size -Sum
$colItems = (Get-ChildItem C:\Windows | Measure-Object -Property length -Sum)
"{0:N2}" -f ($colItems.sum / 1MB) + " MB"


Get-ciminstance win32_processor | select @{Name="Architecture";Expression={$_.AddressWidth}},numberofcores
Get-CimInstance Win32_Processor | measure numberofcores


Get-CimAssociatedInstance -ComputerName R1L2APP01CLB | measure numberofcores


Get-WmiObject win32_processor
Get-CimInstance Win32_Processor | Out-GridView


Get-Process lsass | select *
get-process lsass | sort pagedmemorysize -Desc | select id,name,*memorysize -first 5

#How to use an object if there isn't a a cmdlet
Get-WmiObject win32_process | foreach {$_.getOwner()} | select user -unique 


#creating custom properties
Get-Process |select id, name, starttime, @{n="Runtime";e={(get-date) - $_.starttime}} |
sort Runtime -Descending | select -first 10



Get-Help robocopy.exe