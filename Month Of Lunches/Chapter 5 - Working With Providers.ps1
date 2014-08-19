
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


#2 Create new item

New-Item C:\Temp\test.txt -ItemType directory
Rename-Item C:\Temp\test.txt -NewName test

#note that "item" is generic for powershell therefore you need to specify
# .. the type of file/item you would like to create.

#Answer!
New-Item C:\Temp\test\testing.txt -ItemType file

#3 Setting the name of the file to something else.

cd .\test
dir

help Set-Item -Examples


Set-Item -Path C:\Temp\test\testing.txt -Value TESTER.txt

Answer: fails because it only changes the value of an item rather than the item itself

#4
-filter : filter by the specified value
-include: include those with a particular name type/value/extension etc
-exclude: excludes item specified / a particular type of file you do not want to see


Get-ChildItem -Include *.txt
Get-ChildItem -filter *.txt
Get-ChildItem -exclude *.txt


help Get-ChildItem -Examples



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