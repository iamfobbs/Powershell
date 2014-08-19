
Working With Providers



#1

#Change the registry property for a registry entry "title: DontPrettyPath" with the Advance registry.

Set-Location -Path hkcu: / cd hkcu

Get-ChildItem -Name 
Get-ChildItem

#... keep setting location to path the registry resides.
Set-Location explorer
Set-Location advance

#once located set to desired value
Set-ItemProperty -Path advanced DontPrettyPath -Value 1

#verify your change was made
Get-ChildItem



#2
#3
#4
#5
#6
#7
#8
#9
#10
#11
#12
#13
#14
#15
#16
#17
#18
#19




ANSWERS


#1
#2
#3
#4
#5
#6
#7
#8
#9
#10
#11
#12
#13
#14
#15
#16
#17
#18
#19