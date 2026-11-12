#!/usr/bin/env bash

INSTALL_PATH='/usr/local/bin/kubectl'

if [ ! -f $INSTALL_PATH ]; then
  echo "No existing binary at $INSTALL_PATH.  Copying local ./kubectl..."
  sudo cp ./kubectl $INSTALL_PATH
  exit 0
fi

if [[ -z "$(diff $INSTALL_PATH ./kubectl)" ]]; then
  echo "No changes detected between local ./kubectl and installed $INSTALL_PATH.  Exiting..."
  exit 0
fi


version=$(kubectl version --client=true --output=json | jq -r '.clientVersion.gitVersion' | cut -d 'v' -f 2)

echo "Moving $INSTALL_PATH to ${INSTALL_PATH}${version}..."
sudo mv -f $INSTALL_PATH ${INSTALL_PATH}${version}

echo "Copying ./kubectl to ${INSTALL_PATH}..."
sudo cp ./kubectl $INSTALL_PATH
