FROM ubuntu:latest

LABEL maintainer="Bl4ckr053- credits to Alexis Ahmed for inspiration and starting me off"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/OSINT 

# Install Essentials
RUN apt update && \
    apt install -y --no-install-recommends \
    build-essential \
    tilix \
    gcc \
    iputils-ping\
    git \
    vim \
    wget \
    awscli \
    tzdata \
    curl \
    make \
    nmap \
    whois \
    python3 \
    python3-pip \
    perl \
    nikto \
    dnsutils \
    net-tools \
    zsh\
    nano\
    && rm -rf /var/lib/apt/lists/*

# Install Dependencies
RUN apt update && \
    apt install -y --no-install-recommends \
    # dirb
    dirb \
    # dnsenum
    cpanminus \
    # wfuzz
    python-pycurl \
    # knock
    python-dnspython \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    # masscan
    libpcap-dev \
    # theharvester
    python3.7 \
    # joomscan
    libwww-perl \
    # dnsrecon
    dnsrecon \
    # zsh
    powerline\
    # zsh
    fonts-powerline\
    && rm -rf /var/lib/apt/lists/*

# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools && python3.7 -m pip install --upgrade setuptools

# Sublist3r
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    pip install -r requirements.txt && \
    ln -s ${HOME}/toolkit/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

# wfuzz
RUN pip install wfuzz


# wafw00f
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/enablesecurity/wafw00f.git && \
    cd wafw00f && \
    chmod +x setup.py && \
    python setup.py install

# wpscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan

# masscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/toolkit/masscan/bin/masscan /usr/local/bin/masscan    


# Recon-ng
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    pip3 install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf ${HOME}/toolkit/recon-ng/recon-ng /usr/local/bin/recon-ng

# theHarvester
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/theHarvester.git && \
    cd theHarvester && \
    python3 -m pip install -r requirements.txt && \
    chmod +x theHarvester.py && \
    ln -sf ${HOME}/toolkit/theHarvester/theHarvester.py /usr/local/bin/theharvester

# go
RUN cd /opt && \
    wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz && \
    tar -xvf go1.16.4.linux-amd64.tar.gz && \
    rm -rf /opt/go1.16.4.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}

# gobuster
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/OJ/gobuster.git && \
    cd gobuster && \
    go get && go install

# virtual-host-discovery
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/virtual-host-discovery.git && \
    cd virtual-host-discovery && \
    chmod +x scan.rb && \
    ln -sf ${HOME}/toolkit/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery


# fierce
RUN python3 -m pip install fierce

# droopsecan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/droope/droopescan.git && \
    cd droopescan && \
    pip install -r requirements.txt


# ffuf
RUN go get -u github.com/ffuf/ffuf

# httprobe
RUN go get -u github.com/tomnomnom/httprobe

# Katoolin
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/LionSec/katoolin.git && \
    cd katoolin && \
    chmod +x katoolin.py


# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache