#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY "EventService/EventAPI.sln" "EventService/EventAPI.sln"
COPY ["EventService/EventAPI/EventAPI.csproj", "EventService/EventAPI/EventAPI.csproj"]
COPY ["EventService/EventAPI.Services/EventAPI.Services.csproj", "EventService/EventAPI.Services/EventAPI.Services.csproj"]
COPY ["EventService/EventAPI.Data/EventAPI.Data.csproj", "EventService/EventAPI.Data/EventAPI.Data.csproj"]
COPY ["EventService/EventAPI.Models/EventAPI.Models.csproj", "EventService/EventAPI.Models/EventAPI.Models.csproj"]
RUN dotnet restore "EventService/EventAPI.sln"

COPY . .
WORKDIR "/src/EventService/EventAPI"
RUN dotnet build "EventAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "EventAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "EventAPI.dll"]