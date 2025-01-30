#!/usr/bin/env bash

# Note: this is a pretty coarse script without error handling.
# Use it at your own risk.

VERSION="${1}"

if [[ -z "${VERSION}" ]]; then
  echo "Version is required as first argument."
  exit 1
fi

INSTALL_PATH=$(which kubectl | rev | cut -d '/' -f2- | rev)

OS=""

case "$OSTYPE" in
  darwin*)  OS="darwin" ;; 
  linux*)   OS="linux" ;;
  *)        echo "unknown OS: $OSTYPE" && exit 1 ;;
esac

ARCH=$(uname -m)



curl -L --output "kubectl${VERSION}" "https://dl.k8s.io/release/v${VERSION}/bin/${OS}/${ARCH}/kubectl"

chmod +x "./kubectl${VERSION}"
sudo mv "./kubectl${VERSION}" "${INSTALL_PATH}/kubectl${VERSION}"

${INSTALL_PATH}/kubectl${VERSION} version --client
