# ASP.NET Web Forms, Visual Basic 6 and Docker
How to dockerize an ASP.NET Web Forms that uses Visual Basic 6 (COM) libraries

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

> <em>asp.net</em>, <em>web forms</em>, <em>visual basic 6</em>, <em>vb6</em>, <em>com objects</em>, <em>com library</em>, <em>sqlserver</em>, <em>windows</em>, <em>docker</em>

### Prerequisites

You should be comfortable with [ASP.NET Web Forms](https://dotnet.microsoft.com/apps/aspnet/web-forms), [.NET Framework 4.8](https://dotnet.microsoft.com/download/dotnet-framework/net48), [The COM Library](https://docs.microsoft.com/en-us/windows/win32/com/the-com-library), [SQL Server on Windows](https://www.microsoft.com/en-US/sql-server/sql-server-downloads) and have some knowledge of [Docker for Windows](https://docs.docker.com/docker-for-windows/install/) and [Powershell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1)

Please ensure that you have installed:
* [.NET Framework 4.8 Developer Pack](https://dotnet.microsoft.com/download/dotnet-framework/net48)
* [Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
* [PowerShell on Windows](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1)
* [VS Code](https://code.visualstudio.com/)
* [SQL Server 2019 Express](https://www.microsoft.com/en-US/sql-server/sql-server-downloads) or [SQL Server 2019 Developer on Windows](https://www.microsoft.com/en-US/sql-server/sql-server-downloads)
* [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)

I also recomend to Install [Visual Studio Community](https://visualstudio.microsoft.com/downloads/)

And of course, if you want to open, edit and build Visual Basic 6 libraries, you will have to need your own user licence of Microsoft Visual Studio 6.
If you need more information about how to install Visual Basic Studio 6 on Windows 10 machine, please follow Giorgio Brausi's article [Installing Visual Basic/Studio 6 on Windows 10](http://nuke.vbcorner.net/Articles/VB60/VisualStudio6Installer/tabid/93/language/en-US/Default.aspx)

Although I've uploaded the rest of the components you'll need in the output directory of this repository, you can also find them at:

* [Service Pack 6 for Visual Basic 6.0: Run-Time Redistribution Pack (vbrun60sp6.exe)](https://www.microsoft.com/en-us/download/details.aspx?id=24417) 
* [Microsoft ActiveX Data Objects 6.1 Library (C:\Program Files (x86)\Common Files\System\ado\msado15.dll)](https://www.microsoft.com/en-gb/download/details.aspx?id=13255)
* [Microsoft OLE DB Driver for SQL Server (SQLOLEDB.1 provider)](https://docs.microsoft.com/en-us/sql/connect/oledb/oledb-driver-for-sql-server?view=sql-server-ver15)


### Installing


Clone the repository into your local machine

```
git clone https://github.com/jporcarn/docker.git aspnetvb6
```

In the output folder, you can find the rest of the components.
Go ahead and install them all in your local machine in case you want to build and test this solution locally. You'll also need them installed in your machine in case you want to build your own solution.


## Deployment

Restore [AdventureWorksLT2019](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms) sample database. You can use the .bak file to restore your sample database to your SQL Server instance

Open powershell or cmd in the folder where you've cloned the repository (eg.: aspnetvb6) and register <em>AdventureWorksLT.dll</em> COM library.
In vb6-logic folder you shoud find AdventureWorksLT.dll already built. 
```bash
C:\Windows\syswow64\regsvr32.exe ./vb6-logic/bin/AdventureWorksLT.dll
```

Start Visual Studio or VS Code and open the <em>web-app.sln</em> solution placed in the web-app folder.

Change the connection string to match your Sql Server. You can use Integrated Security when deploying in local server.
```html
<configuration>
  <connectionStrings>
    <add name="AdventureWorksLT2019" connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=AdventureWorksLT2019;Integrated Security=SSPI;" providerName="System.Data.SqlClient" />
  </connectionStrings>
</configuration>
```

Restore Nuget packeges

Build the solution


## Running the tests

Open Visual Studio and start debugging <em>web-app.csproj</em> project using IIS Express.

Your preferred browser should start on https://localhost:port hosted in IIS Express.

On landing page click on <em>Customers</em> button.

A list with all customer's should appear.

If something went wrong, the error message should be shown just below the Customer's button.

## Docker Deployment 

To be able to connect to your local SqlServer from Docker container you'll have to change the connection string and enable SqlServer authentication.

Open Web.config file and change the connection string. Put down your IP address, port and enable SqlServer authentication.
```html
<configuration>
  <connectionStrings>
    <add name="AdventureWorksLT2019" connectionString="Data Source=[YOUR HOST IP]\SQLEXPRESS,1433;Initial Catalog=AdventureWorksLT2019;User ID=sa;Password=[SA PASSWORD];" />
  </connectionStrings>

</configuration>
```

Publish the <em>web-app.csproj</em> to <em>output/app.publish</em> folder.
FolderProfile.pubxml
```xml
<?xml version="1.0" encoding="utf-8"?>
<!--
https://go.microsoft.com/fwlink/?LinkID=208121. 
-->
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <DeleteExistingFiles>True</DeleteExistingFiles>
    <ExcludeApp_Data>False</ExcludeApp_Data>
    <LaunchSiteAfterPublish>True</LaunchSiteAfterPublish>
    <LastUsedBuildConfiguration>Debug</LastUsedBuildConfiguration>
    <LastUsedPlatform>Any CPU</LastUsedPlatform>
    <PublishProvider>FileSystem</PublishProvider>
    <PublishUrl>..\..\output\app.publish\</PublishUrl>
    <WebPublishMethod>FileSystem</WebPublishMethod>
    <SiteUrlToLaunchAfterPublish />
  </PropertyGroup>
</Project>
```

Open Powershell and run the following commands
```bash
docker image build --tag aspnetvb6 .
```

```bash
docker container run --detach --publish 80 aspnetvb6
```

```bash
docker ps
```

```bash
docker inspect [container id]
```

Copy the IP address of the docker container and open a new window in your browser.

Paste the container's IP address and now the landing page should be loaded from the docker container.

On conainer's landing page, click on <em>Customers</em> button.

A list with all customer's should appear.

## Built With

* [.NET Framework 4.8 Developer Pack](https://dotnet.microsoft.com/download/dotnet-framework/net48)
* [Service Pack 6 for Visual Basic 6.0: Run-Time Redistribution Pack](https://www.microsoft.com/en-us/download/details.aspx?id=24417)
* [Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)


## Authors

* **Josep Porcar** - *Initial work* - [Docker](https://github.com/jporcarn/docker)

See also [contributors](https://github.com/jporcarn).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details