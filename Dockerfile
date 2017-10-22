FROM hypriot/rpi-alpine:3.6

RUN apk --update add ca-certificates wget python curl tar

# Install gcloud and kubectl
# kubectl will be available at /google-cloud-sdk/bin/kubectl
# This is added to $PATH
ENV HOME /
ENV PATH /google-cloud-sdk/bin:$PATH
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc
# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true
RUN google-cloud-sdk/bin/gcloud components install kubectl

# Install Helm
ENV VERSION v2.6.2
ENV FILENAME helm-${VERSION}-linux-arm.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${FILENAME}

RUN curl -o /tmp/$FILENAME ${HELM_URL} \
  && tar -zxvf /tmp/${FILENAME} -C /tmp \
  && mv /tmp/linux-arm/helm /bin/helm \
  && rm -rf /tmp
