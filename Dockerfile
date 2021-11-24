FROM ubuntu:20.04

#Build phase
RUN apt-get update && apt-get install -y\ 
    curl \
    ca-certificates \
    gnupg \
    firefox \
    apt-transport-https \
    net-tools

#kubectl
#Download Kubectl latest release
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#Download checksum
RUN curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 
#kops
RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
RUN chmod +x kops && mv kops /usr/local/bin/kops
#Google cloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

RUN export DISPLAY=:0

COPY *.sh *.yaml /
COPY deployement /deployement
CMD ["/bin/bash", "./script.sh"]
#CMD echo "$(<kubectl.sha256) kubectl" | sha256sum --check \ 
#    gcloud init \
#    gcloud auth application-default login