$computers = "R1L2MGT01CLB"
$dcs = foreach ($computer in $computers) {
    $ntds = dir '\\R1L1MGT01CLB\c$\Windows\NTDS\ntds.dit'
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $computer
    $DSLog = Get-EventLog -logname application -newest 20 -computer $computer
    $Netlogon = Get-WmiObject win32_share -Filter "name='Netlogon'" -ComputerName $computer
    $Sysvol = Get-WmiObject win32_share -Filter "name='SysVol'" -ComputerName $computer

    #create a custom object for each domain controller
    [pscustomobject][ordered]@{
        Computername = $os.CSName
        OperatingSystem = $os.caption
        ServicePack = $os.ServicePackMajorVersion
        NTDS = $NTDS
        DSLog = $DSLog
        Netlogon = $Netlogon.Path
        SysVol = $Sysvol.Path
     }
}

$dcs
$dcs | select -Expandproperty ntds

#or expand like this
#THIS CAN ONLY BE DONE WITH A CUSTOM OBJECT CREATED! Remember that!
$dcs.dslog | where {$_.entrytype -ne 'information'} | select timegenerated, entrytype, source, message,
@{N="ComputerName";E={$_.Machinename}} 




#3
Get-EventLog  - display 100 most recent system event logs
Show Only - 
= TimeGenerated, 
= A property that shows how old an event is
= Source
= display computername instead of Machinename



#EXERCISE
#1
Get-EventLog -list
Get-EventLog application -Newest 10 | select max | gm

#2

#3
Get-EventLog system -Newest 100 | gm

Get-EventLog system -Newest 10 | select TimeGenerated, timewritten

Test-Connection r1l2mgt02cla