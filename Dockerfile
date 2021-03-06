FROM hypriot/rpi-alpine:3.6

RUN apk --update add ca-certificates wget python curl tar git

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/arm/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

# Install Helm
ENV VERSION v2.5.0
ENV FILENAME helm-${VERSION}-linux-arm.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${FILENAME}

RUN curl -o /tmp/$FILENAME ${HELM_URL} \
  && tar -zxvf /tmp/${FILENAME} -C /tmp \
  && mv /tmp/linux-arm/helm /bin/helm \
  && rm -rf /tmp
