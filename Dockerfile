FROM ://microsoft.com AS build
WORKDIR /src
COPY ["LeaveManagementSystem/LeaveManagementSystem.csproj", "LeaveManagementSystem/"]
RUN dotnet restore "LeaveManagementSystem/LeaveManagementSystem.csproj"
COPY . .
WORKDIR "/src/LeaveManagementSystem"
RUN dotnet publish "LeaveManagementSystem.csproj" -c Release -o /app/publish --no-restore

FROM ://microsoft.com AS final
WORKDIR /app
RUN apt-get update && apt-get install -y libfontconfig1 && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "LeaveManagementSystem.dll"]
