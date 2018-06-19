#!/bin/bash
set -e

CISHELL_APPS=`cd $(dirname $0); pwd`
CISHELL_CORE="${CISHELL_APPS}/../CIShell"
CISHELL_REREFENCE_GUI="${CISHELL_APPS}/../cishell-reference-gui"
CISHELL_PLUGINS="${CISHELL_APPS}/../cishell-plugins"

if [ "$1" != "" ]; then
  CISHELL_CORE=$1
fi
if [ "$2" != "" ]; then
  CISHELL_REREFENCE_GUI=$2
fi

if [ "$3" != "" ]; then
  CISHELL_PLUGINS=$3
fi

for repo in "${CISHELL_CORE} ${CISHELL_REREFENCE_GUI} ${CISHELL_PLUGINS} ${CISHELL_APPS}"; do
  pushd $repo
    mvn clean
  popd
done

pushd $CISHELL_REREFENCE_GUI
  rm -rf deployment/org.cishell.reference.releng/build
  rm -rf deployment/org.cishell.p2/build
popd

pushd $CISHELL_APPS
  rm -rf dist
  rm -rf sci2/deployment/edu.iu.sci2.releng/build
  rm -rf sci2/deployment/edu.iu.sci2.p2/build
popd
