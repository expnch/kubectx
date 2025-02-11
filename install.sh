#!/usr/bin/env bash

KUBE_INSTALL_PATH='/usr/local/bin/kubectl'
HELM_INSTALL_PATH='/usr/local/bin/helm'

if [ ! -f $KUBE_INSTALL_PATH ]; then
  echo "No existing binary at $KUBE_INSTALL_PATH.  Copying local ./kubectl..."
  sudo cp ./kubectl $KUBE_INSTALL_PATH
fi

if [ ! -f $HELM_INSTALL_PATH ]; then
  echo "No existing binary at $HELM_INSTALL_PATH.  Copying local ./helm..."
  sudo cp ./helm $HELM_INSTALL_PATH
fi

if [[ -n "$(diff $KUBE_INSTALL_PATH ./kubectl)" ]]; then
  echo "Changes detected between local ./kubectl and installed $KUBE_INSTALL_PATH."

  if [[ "$(head -n 1 ${KUBE_INSTALL_PATH})" == "#!/usr/bin/env bash" ]]; then
    echo "Found existing script at ${KUBE_INSTALL_PATH}. It will be moved to ${KUBE_INSTALL_PATH}.backup."
    sudo mv -f $KUBE_INSTALL_PATH ${KUBE_INSTALL_PATH}.backup
  else
    kube_version=$(kubectl version --client=true --output=json | jq -r '.clientVersion.gitVersion' | cut -d 'v' -f 2)
    echo "Moving $KUBE_INSTALL_PATH to ${KUBE_INSTALL_PATH}${kube_version}..."
    sudo mv -f $KUBE_INSTALL_PATH ${KUBE_INSTALL_PATH}${kube_version}
  fi

  echo "Copying ./kubectl to ${KUBE_INSTALL_PATH}..."
  sudo cp ./kubectl $KUBE_INSTALL_PATH
fi

if [[ -n "$(diff $HELM_INSTALL_PATH ./helm)" ]]; then
  echo "Changes detected between local ./helm and installed $HELM_INSTALL_PATH."

  if [[ "$(head -n 1 ${HELM_INSTALL_PATH})" == "#!/usr/bin/env bash" ]]; then
    echo "Found existing script at ${HELM_INSTALL_PATH}. It will be moved to ${HELM_INSTALL_PATH}.backup."
    sudo mv -f $HELM_INSTALL_PATH ${HELM_INSTALL_PATH}.backup
  else
    helm_version=$(helm version --short | cut -d '+' -f 1 | cut -d 'v' -f 2)
    echo "Moving $HELM_INSTALL_PATH to ${HELM_INSTALL_PATH}${kube_version}..."
    sudo mv -f $HELM_INSTALL_PATH ${HELM_INSTALL_PATH}${kube_version}
  fi
  
  echo "Copying ./helm to ${HELM_INSTALL_PATH}..."
  sudo cp ./kubectl $HELM_INSTALL_PATH
fi

echo "Finished installing latest versions of kubectl and helm shims!"
