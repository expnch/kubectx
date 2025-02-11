#!/usr/bin/env bash

# Note: this is a pretty coarse script without error handling.
# Use it at your own risk.

VERSION="${1}"

if [[ -z "${VERSION}" ]]; then
  echo "Version is required as first argument."
  exit 1
fi

INSTALL_PATH=$(which helm | rev | cut -d '/' -f2- | rev)

if [[ "${INSTALL_PATH}" == "helm not found" ]]; then
  INSTALL_PATH="/usr/local/bin"
fi

OS=""

case "$OSTYPE" in
  darwin*)  OS="darwin" ;; 
  linux*)   OS="linux" ;;
  *)        echo "unknown OS: $OSTYPE" && exit 1 ;;
esac

ARCH=$(uname -m)

mkdir ./temp
curl -L --output "./temp/helm.tar.gz" "https://get.helm.sh/helm-v${VERSION}-${OS}-${ARCH}.tar.gz"
tar -xf "./temp/helm${VERSION}.tar.gz"

sudo cp "./temp/${OS}-${ARCH}/helm" "${INSTALL_PATH}/helm${VERSION}"
rm -rf "./temp"

${INSTALL_PATH}/helm${VERSION} version
