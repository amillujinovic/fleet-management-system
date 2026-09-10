FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
WORKDIR /app
COPY projekatFlutter.csproj .
RUN dotnet restore
COPY . .
RUN dotnet build
RUN dotnet publish -c Release -o /app/publish
###
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
CMD [ "dotnet", "projekatFlutter.dll"]
EXPOSE 8080