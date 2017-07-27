Basic Docker container for ASP.NET Core

Compiled (published) ASP.NET Core application should be connected to volume '/app'.
Application entry dll is defined by environment variable ASPNETCORE_ENTRY.

Run example:
```
docker run -p 5000:5000 -v <my_application_path>:/app -e "ASPNETCORE_ENTRY=my_application_entry.dll" --name "my_application" nazar89/dotnet-core
```
