FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
COPY output/vbrun60sp6.exe .
COPY output/msoledbsql.msi .
COPY output/accessdatabaseengine.exe .
SHELL ["powershell"]

#RUN Remove-Item "c:\temp" -Force  -Recurse -ErrorAction SilentlyContinue

RUN C:\Windows\System32\inetsrv\appcmd.exe set apppool /apppool.name:DefaultAppPool /enable32BitAppOnWin64:true

RUN Start-Process -FilePath .\accessdatabaseengine.exe -ArgumentList @("'/quiet'", "'/norestart'") -Wait
RUN Start-Process -FilePath .\msoledbsql.msi -ArgumentList @("'/quiet'", "'/norestart'") -Wait

# Optional. Just in case you want to check what files the instalation is deploying
RUN Start-Process -FilePath .\vbrun60sp6.exe -ArgumentList @("'/Q'", "'/T:c:\temp'", "'/C'") -Wait

RUN Start-Process .\vbrun60sp6.exe -ArgumentList @("'/Q'")
# Directory of C:\Windows\SysWOW64 MSVBVM60.DLL



WORKDIR /inetpub/wwwroot
COPY ./output/app.publish .
COPY ./vb6-logic/bin ./bin

RUN C:\Windows\System32\inetsrv\appcmd.exe set apppool /apppool.name:DefaultAppPool /enable32BitAppOnWin64:true

RUN C:\Windows\syswow64\regsvr32.exe ./bin/AdventureWorksLT.dll /s