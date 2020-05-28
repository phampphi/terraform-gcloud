FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine

ENV TERRAFORM_VERSION=0.12.25

RUN apk --update add unzip curl && \
    # install terraform
    curl -fsSLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip; unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    # install mysql-client
    apk add mysql-client && \
    # setup workdir
    mkdir /src && mkdir -p /.config/gcloud/logs && \ 
    # clean up
    rm -rf /var/cache/apk/* /tmp/*

WORKDIR /src