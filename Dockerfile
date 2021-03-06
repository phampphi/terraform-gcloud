FROM google/cloud-sdk:alpine

ENV TERRAFORM_VERSION=0.12.25 \
    GOSU_VERSION=1.12 \
    KUBECTL_VERSION=1.18.0

ARG user=nobody
ARG group=nobody

RUN apk --update add --no-cache unzip curl dpkg && \
    # install terraform
    curl -fsSLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip; unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    # install mysql-client
    apk add mysql-client && \
    # install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
    # install gosu
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    curl -fsLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$dpkgArch" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    # setup work dir
    mkdir /home/${user} && chown -R ${user}:${group} /home/${user}/ && \
    # clean up
    rm -rf /var/cache/apk/* /tmp/*

WORKDIR /home/${user}