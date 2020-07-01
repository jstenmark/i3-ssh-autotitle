#!/bin/bash
set -x

case $1 in

  install-shfmt)
    SHFMT_VERSION="$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | jq -r -M '.tag_name')"
    curl -Lo shfmt https://github.com/mvdan/sh/releases/download/"${SHFMT_VERSION}"/shfmt_"${SHFMT_VERSION}"_linux_amd64
    chmod +x ./shfmt
    ./shfmt --version
    ;;

  shfmt)
    find . -iname "aliases" -exec ./shfmt -i 4 -ci -d {} +
    ;;

  # We use + instead of \; here because find doesn't pass
  # the exit code through when used with \;
  shellcheck)
    find . -iname "aliases" -exec shellcheck {} +
    ;;

  *)
    exit 1
    ;;
esac