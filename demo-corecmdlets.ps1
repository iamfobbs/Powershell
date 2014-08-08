Get-ChildItem

Get-process | sort workingset -Descending | select -First 10


dir C:\Users\ofoborhd\Downloads -file | measure length -Sum -average
dir C:\Users\ofoborhd\Downloads -file | measure length -head

Get-Content
###############



#DEMO

#get-childitem

help dir -ShowWindow

dir \\public.bsi.cloud\cloud\IIS\Install
#goes through all child directoriesd as well
dir \\public.bsi.cloud\cloud\IIS\Install -Recurse

#filtering techniques
$a = @()
$a = { dir C:\Users\ofoborhd\Documents\*.ps1 -Recurse}
&$a
$b = { dir C:\Users\ofoborhd\Documents -Include *.ps1 -Recurse}
&$b
$c = { dir C:\Users\ofoborhd\Documents -Filter *.ps1 -Recurse}
&$c

#measure command
Measure-Command $a
Measure-Command $b
Measure-Command $c

#
Get-PSProvider
Push-Location
cd function:

#getting items bu attribute
#listing just the directories
dir \\public.bsi.cloud\cloud\IIS\ -directory
#listing just the files
dir C:\Users\ofoborhd\Documents -file -recurse

#hidden directories
dir c:\ -Hidden -file

##### WHERE-OBJECT #######

#legacy syntax
Get-Service | where {$_.status -eq 'stopped'}

#new syntax - workings only in powershell 3
Get-Service | where status -eq 'stopped'

dir \\public.bsi.cloud\cloud\iis\Install | where Length -ge 100kb

#Last write time was great than 90 days #new syntax
dir C:\Users\ofoborhd\Documents\*.txt | where Lastwritetime -gt (Get-Date).AddDays(-90)

#legacy
dir C:\Users\ofoborhd\Documents\*.txt | where { ($_.LastWriteTime -gt 
(Get-Date).AddDays(-90)) -and ($_.Length -gt 15kb)}



#always filter early as possible
#both commands will work but one is better than the other

Measure-Command { dir c:\user\ofoborh\documents -Recurse | where 
{$_.extention -eq '.xml'}}

#faster
#TESTING SPEEDS
Measure-Command { dir c:\user\ofoborh\documents -Recurse -Filter '*.xml'}

##### SORTING OBJECT ##############

Get-Process -ComputerName $computers | sort ws | select ws, vm, ProcessName, $env:COMPUTERNAME

Get-Process -ComputerName $computers | sort ws
Get-Process -ComputerName $computers | sort ws -Descending

notepad

#starttime property only available locally
#skip processes without a starttime property
notepad
Get-Process | where StartTime | sort @{Expression={(Get-Date) - $_.starttime}} 

##### SELECTC-OBJECT ####
#object
#most used resource
Get-Process -ComputerName R1L1WEB02CLA | sort ws -Descending | select -First 5

Get-Process -ComputerName R1L1WEB02CLA | sort ws -Descending | where {$_.ProcessName -like 'w3w*'}

#least resource
Get-Process -ComputerName R1L1WEB02CLA | sort ws -Descending | select -last 5

#
dir C:\Users\ofoborhd\Documents\ -file | select name,Length,LastWriteTime

#creating customproperties
#doing the same thing as above but instead creating your own custom titles
$data = dir C:\Users\ofoborhd\Documents -file | 
select name,@{Name="Size";Expression={$_.length}}, 
LastWriteTime, @{Name="Age";Expression={
((get-date) - $_.lastwritetime).days} } |
sort size -descending

$data
#note that select is not the same as formating
$data
$data | ft -auto

#unique
get-process -ComputerName $env:COMPUTERNAME | select name -Unique
get-process -ComputerName $env:COMPUTERNAME | select name -Unique | sort name

#EXAMPLE.. It does not display the duplicated values/ select unique objects
1,4,5,1,6,6,7,8 | select -Unique
Get-Process -ComputerName $env:COMPUTERNAME | select -Unique

#expanding properties
#hard to read data because it holds a collection cmdlets
Get-Service winmgmt -ComputerName R1L2WEB01CLA | select DependentServices
#further expansion
get-service winmgmt -ComputerName R1L2WEB01CLA | select -ExpandProperty DependentServices


### GROUPING OBJECTS ####
$logs = Get-EventLog application -Newest 100  -ComputerName R1L2WEB01CLA | group Source
$logs

#this is now a different object
$logs | sort count -Descending
$logs | gm


#get grouped object
$logs[2].group
$logs[2].group | select entrytype,message | ft -a

#For get the errors. HOW MANY TYPES OF ERRORS DID I GET TODAY!
#create wa group infor without the elements
Get-EventLog system -newest 100 -ComputerName R1L1WEB01CLA | group EntryType -NoElement |
sort count

#OR create a Hashtable
$grouphash = Get-EventLog system -Newest 100 -ComputerName R1L1WEB01CLA | Group EntryType -AsHashTable -AsString

#Saving output in a hash table and as string gives you a lot of flexibility with how you can retrive data
$grouphash
$grouphash.Error


#MEASURE OBJECT
#always retrieves the count vaue
Get-Process | measure

#measure everything
#all in bytes
Get-Process | measure workingset -sum -Minimum -Maximum -Average


#another way it might be used
#Gives all the top level folders and their size
dir \\r1l2web02cla\C$ -Directory | select fullname, lastwritetime, 
@{name="Size";Expression={$stats = dir $_.Fullname -Recurse | Measure-Object Length -sum
$stats.sum}
} | Format-table


#GET-CONTENT
Get-Content C:\Work\computers.txt

#get the head (alias parameter)
Get-Content C:\Windows\WindowsUpdate.log -head 5

Get-Content C:\Windows\WindowsUpdate.log -tail 5

#get tail and watch
Get-Content C:\Work\computers.txt -tail 1 -Wait


########################
#PUTTING IT ALLL TOGETHER

test connection
Get-Content C:\Work\computers.txt | foreach {Test-Connection $_ -Count 1 -quiet }
Get-Content C:\Work\computers.txt | measure

$data = get-wmiobject win32_operatingsystem -computername (get-content C:\Work\computers.txt | where {$_} ) |
select caption,@{Name="Computername";Expression={$_.CSName}},
@{Name="FreePhysMemBytes";Expression={$_.FreePhysicalMemory*1kb}},
@{Name="TotalPhysMemBytes";Expression={$_.TotalVisibleMemorySize*1kb}},
@{Name="PercentFreeMem";Expression={
($_.FreePhysicalMemory/$_.TotalVisibleMemmorySize)*100}},
NumberofUsers,Numberofprocessess |
Group Computername -AsHashTable -AsString

#create a hash table. now you can divide data as you see fit
$data

#example... 
$data.R1L1WEB01CLA

help hash

#say we want to analyse the data
#
$data.GetEnumerator() | select -Expand value | where {$_.percentfreemem -le 25}
sort PercentFreeMem -Descending |
select Comp*,P*Num*



######## LAB ######
#1. list all files and subfolders
dir c:\netcheck -Recurse -Filter '*.txt'

#2. Repeat and measure how many txt files and their total size
#tell how many directories are there.
dir C:\netcheck -Directory -recurse
$fsize = dir C:\Netcheck -Recurse -Filter '*.txt' | Measure-Object length -Sum
"{0:N2}" -f ($fsize.sum / 1MB) + " MB"

#2. Repeat and measure how many txt files and their total size
dir c:\work  -Recurse -Filter '*.txt' | Measure-Object -Sum


#3 get process and count and sort by company name
#REMEMBER TO FIND OUT MORE ABOUT A CMDLET DO "GET-MEMBER"
Get-Process | gm #Not you know what properties you can use

$pcomp = Get-Process | select id, process, company | group company
$pcomp | sort company -Descending | select count, name | ft -a

#4
$proc = Get-Process | select id, name, WorkingSet, StartTime | Format-Table
$proc | sort -first 10

$proc.GetEnumerator() | where {$_.starttime -isnot 'null'}


#SAMPLES
Get-ChildItem C:\Windows -Recurse| Measure-Object -Property size -Sum
$colItems = (Get-ChildItem C:\Windows | Measure-Object -Property length -Sum)
"{0:N2}" -f ($colItems.sum / 1MB) + " MB"






