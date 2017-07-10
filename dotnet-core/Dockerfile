FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y apt-transport-https && \
    sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && \
    apt-get update -y && \
    apt-get install -y dotnet-dev-1.0.4
	
VOLUME ["/app"]

ENV ASPNETCORE_ENTRY application.dll
ENV ASPNETCORE_ENVIRONMENT Production

WORKDIR "/app"
EXPOSE 5000

ENTRYPOINT dotnet $ASPNETCORE_ENTRY
