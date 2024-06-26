# Use the .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory inside the container
WORKDIR /webapp

# Copy the project files to the container
COPY . ./

# Build the application
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Create the final image using the .NET Core runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /webapp
COPY --from=build-env /webapp/out .

# Run the application
ENTRYPOINT ["dotnet", "webapp.dll", "--urls", "http://*:5000"]
