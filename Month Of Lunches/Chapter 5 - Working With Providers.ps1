
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


#1 Refer to Q1.
#2 Refer to Q2
#3 The File sysyem does not support the action.

#4
Include and exclude: must be used with –Recurse or if querying a container. 
Filter uses the PSProviders filter capability which not all Providers support. 

#NOTE: recurse goes through the entire directory/including sub-directories

For example, you could use DIR –filter in the file system but not in the registry.
Although you could use DIR –include in the registry to achieve almost the same type of filtering result.