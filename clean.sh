#!/bin/bash
set -e

CISHELL_APPS=$(dirname $0)
CISHELL_CORE="${CISHELL_APPS}/../CIShell"
CISHELL_PLUGINS="${CISHELL_APPS}/../cishell-plugins"

if [ "$1" != "" ]; then
  CISHELL_CORE=$1
fi
if [ "$2" != "" ]; then
  CISHELL_PLUGINS=$2
fi

for repo in "${CISHELL_CORE} ${CISHELL_PLUGINS} ${CISHELL_APPS}"; do
  pushd $repo
    mvn -P build-nonpde clean
  popd
done

pushd $CISHELL_APPS
  rm -rf dist
popd
