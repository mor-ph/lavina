#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/sdk AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk AS build
WORKDIR /src

COPY "CommentService/CommentService/CommentService.sln" "CommentService/CommentService/CommentService.sln"
COPY ["CommentService/CommentService/CommentService/CommentService.csproj", "CommentService/CommentService/CommentService/CommentService.csproj"]

RUN dotnet restore "CommentService/CommentService/CommentService.sln"

COPY . .

WORKDIR "/src/CommentService/CommentService/CommentService"

RUN dotnet build "CommentService.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CommentService.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CommentService.dll"]