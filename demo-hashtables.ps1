
$hash=@{A=123;B="foo";C=3.14}


#creating
$e = @{name="Dennis";Title="MVP";Computer=$env:COMPUTERNAME}

#enumerating key/lists only the key headers
$e.Keys

#referering elements
$e.item("computer")
#another way to do this
$e.computer

#creating an empty hasg tag
$f=@{}

#adding to hash tag
$f.add("Name","Jeff")
$f.add("Company","Globomantics")
$f.add("Office","London")
$f

#changing
$f.office
$f.office = "Bordeaux"

#keys must be unique
$f.add("Name","Jane") #kay has to be different everytime
#way to check if a key exists
$f.ContainsKey("Name") #true signifies its already present

#removing
$f.Remove("Name")
$f

#group-object //some cmdlets can create hash tables
#example
#NOTE: result is stored as a HASH TABLE
$source = Get-EventLog system -Newest 100 | group source -AsHashTable
$source

#get specific entry
$source.EventLog #provides an array of eventlog entries

#handle names with spaces
$source.'service control manager'

#this is an array of eventlog objects
$source.EventLog[0..3]
$source.EventLog[0].Message

#using an enumerator
$source | Get-Member
$source.GetEnumerator() | gm

help enumerator
help about_hash_tables

#this will fail because
$source | sort name | select -First 5
#here's the correct approach
$source.GetEnumerator() | sort name | select -First 5

#another approach that will fail
$source | where {$_ -match "winlogon"}

#although, we could do this
$source.Keys | where {$_ -match "winlogon"} | foreach {$source.item($_)}

#but this is easier and slightly faster
$source.GetEnumerator() | where {$_.name -match "winlogon"} | select -Expand value

#hash tables are unordered
#concepts of ordererd and unordered

#UNORDERED
$hash = @{
Name="Dennis"
Company="BSI"
Office="Chiswick"
Computer=$env:COMPUTERNAME
OS= (Get-CimInstance win32_operatingsystem -Property caption).caption }
$hash

#ORDERED
$hash=  [ordered]@{
Name="Dennis"
Company="BSI"
Office="Chiswick"
Computer=$env:COMPUTERNAME
OS= (Get-CimInstance win32_operatingsystem -Property caption).caption }
$hash

#EX.. hash tables as object properties
$os = Get-CimInstance win32_operatingsystem
$cs = Get-CimInstance win32_computersystem

#look
$os
$cs

$properties = [ordered]@{
Computername = $os.CNAME
MemoryMB = $cs.TotalPhysicalMemory/1mb -as [int]
LastBoot = $os.LastBootUpTime }

$properties

#creating a new object
#with this new object we can now export/query the data the way we want.
#creating custom objects
New-Object -TypeName PSobject -Property $properties

#can do the same thing in powershell 3
#hastables as a custom object
[pscustomobject]$properties



##### PRACTICAL 
$computers = $env:COMPUTERNAME, "R1L2WEB02CLA", "R1L1WEB01CLA"
$data = foreach ($computer in $computers) 
{
    #simplied without any real error handling
    $os = Get-CimInstance win32_operatingsystem -ComputerName $computers
    $cs = Get-CimInstance win32_computersystem -ComputerName $computers
    $cdrive = Get-CimInstance win32_logicaldisk -Filter "deviceid='c:'"
        
    [pscustomobject][ordered]@{
    Computername = $os.CSName
    OperatingSystem = $os.Caption
    Arch = $os.OSArchitecture
    MemoryMB = $cs.TotalPhysicalMemory/1mb -as [int]
    PercentFreeC = ($cdrive.FreeSpace/$cdrive.size)*100 -As [int]
    LastBoot = $os.LastBootUpTime
    Runtime = (get-date) - $os.LastBootUptime 
   }
}


$data

#or analyst and sort
$data | sort runtime | select computername, runtime

update-help

help pscustomobject


host

 Get-CimInstance win32_logicaldisk -Filter "deviceid='c:'"