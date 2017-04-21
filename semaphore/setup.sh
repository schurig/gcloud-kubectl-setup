#!/bin/bash

VERSION=152.0.0

## Usage:
## curl https://gist.githubusercontent.com/schurig/f1a48c1ffe63131a2b5f61a92abc98df/raw/semaphore_ci_gcloud_prepare.sh | sh

export PATH=$SEMAPHORE_CACHE_DIR/google-cloud-sdk/bin:$PATH

if [ ! -f "$SEMAPHORE_CACHE_DIR/google-cloud-sdk/bin/gcloud" ]
then
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$VERSION-linux-x86_64.tar.gz
  tar -x -C $SEMAPHORE_CACHE_DIR -f google-cloud-sdk-$VERSION-linux-x86_64.tar.gz
  gcloud --quiet components update --version $VERSION
  gcloud --quiet components update --version $VERSION beta
fi

if [ ! -f "$SEMAPHORE_CACHE_DIR/google-cloud-sdk/bin/kubectl" ]
then
  gcloud --quiet components update --version $VERSION kubectl
fi

