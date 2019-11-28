from python:3.7-stretch


ENV PATH $PATH:/root/.dotnet/tools
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT true
ENV DOTNET_SKD_VERSION 2.2

# install packages
# - azure-cli
# - dotnet sdk
# - powershell
# - functions-core-tools
# - azcopy
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg \
    && mv /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs| sed 's/\..*$//')/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list \
    && apt-get update \
    && apt-get install -y dotnet-sdk-$DOTNET_SKD_VERSION azure-functions-core-tools \
    && dotnet tool install --global PowerShell \
    && wget -O azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux \
    && tar -xf azcopy.tar.gz \
    && cp -pf azcopy_linux_*/azcopy /usr/local/bin/azcopy \
    && chmod +x /usr/local/bin/azcopy \
    && rm -f azcopy.tar.gz 


