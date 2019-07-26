@echo off

::create nuget_pub
if not exist nuget_pub (
    md nuget_pub
)

::clear nuget_pub
for /R "nuget_pub" %%s in (*) do (
    del %%s
)

::Extensions for EntityFrameworkCore
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.MySql -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.MySqlConnector -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.Oracle -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.PostgreSql -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.SqlServer -c Release -o ../../../../nuget_pub
dotnet pack extra/Cosmos.EntityFrameworkCore/src/Cosmos.EntityFrameworkCore.Sqlite -c Release -o ../../../../nuget_pub

for /R "nuget_pub" %%s in (*symbols.nupkg) do (
    del %%s
)

echo.
echo.

set /p key=input key:
set source=https://api.nuget.org/v3/index.json

for /R "nuget_pub" %%s in (*.nupkg) do ( 
    call nuget push %%s %key% -Source %source%	
	echo.
)

pause