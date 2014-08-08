#FORMATING

Get-Process


get-process | Format-Wide
#by 4 column
get-process | Format-Wide -Column 4
get-process | Format-Wide -AutoSize

#sort on property
gsv | sort status | fw -GroupBy status

#list of possibility
Get-Process -ComputerName R1L2WEB02CLA | gm

#formatted table
Get-Process -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA | sort vm -Descending | select id, name, @{N="Memory";E={($_.vm) / 1MB}},
 @{N="ComputerName";E={$_.MachineName}} -first 10 | ft -autosize


#grouping by property
Get-EventLog system -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA -Newest 20 | Format-Table -GroupBy entrytype 
-property TimeGenerated, Source, Messsage -wrap


#should sort first
Get-EventLog system -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA -Newest 20 | sort entrytype | Format-Table -GroupBy entrytype 
-property TimeGenerated, Source, Messsage -wrap


#FORMATING HAS TO BE THE LAST TIME!
#EXAMPLE

#DOES NOT WORK / Not formatted.
Get-CimInstance win32_operatingsystem -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA | 
Format-Table @{N="Operating System";E={ #first trim off the work MS from the caption
[regex]$rx="Microsoft|Windows|\(R\)"
$rx.Replace($_.Caption, "").Trim()}},
installdate, @{N="ComputerName";E={$_.csname}},
@{N="SP";E={$_.ServicePackMajorVersion}} -AutoSize


#REMEMBER FORMAT LAST
#Process data before sorting
#DOES  WORK /  formatted.
Get-CimInstance win32_operatingsystem -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA | sort installDate
Format-Table @{N="Operating System";E={ #first trim off the work MS from the caption
[regex]$rx="Microsoft|Windows|\(R\)"
$rx.Replace($_.Caption, "").Trim()}},
installdate, @{N="ComputerName";E={$_.csname}},
@{N="SP";E={$_.ServicePackMajorVersion}} -AutoSize

#EXPORTS TO TEXT FILE
Get-CimInstance win32_operatingsystem -ComputerName $env:COMPUTERNAME ,R1L2WEB02CLA | 
Format-Table @{N="Operating System";E={ #first trim off the work MS from the caption
[regex]$rx="Microsoft|Windows|\(R\)"
$rx.Replace($_.Caption, "").Trim()}},
installdate, @{N="ComputerName";E={$_.csname}},
@{N="SP";E={$_.ServicePackMajorVersion}} -AutoSize | Out-File \\R1L2WEB01CLA\C$\temp\OSReport.txt -Encoding ascii

#Great way to see Properties
Get-Process system | Format-List *


###
# Different DEFAULT LISTING STYLES
###

Get-Process | ft
Get-Process | fl
dir '\\R1L2WEB01CLA\C$\temp'
dir '\\R1L2WEB01CLA\C$\temp' | FL

#grouping
dir '\\R1L2WEB01CLA\C$\temp' | sort extension | fl -GroupBy extension

#or select properties
dir  '\\R1L2WEB01CLA\C$\temp' | sort extension | fl -GroupBy extension -prop Fullname, Length, Creation, LastWriteTime




#LAB
####
#
dir C:\install -filter *.exe | Format-Wide -column 2

# Display as list
Get-EventLog system -Newest 50 | fl -GroupBy source -Property TimeGenerated, EntryType, Message 

#Group by source and display
Get-EventLog system -Newest 50 | fl -GroupBy source -Property TimeGenerated, EntryType, Message 

#Display as table as above and wrap
Get-EventLog system -Newest 50 | ft -GroupBy source -Property TimeGenerated, EntryType, Message -Wrap 