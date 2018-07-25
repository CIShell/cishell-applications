#!/bin/bash
set -e

CISHELL_APPS=`cd $(dirname $0); pwd`
CISHELL_CORE="${CISHELL_APPS}/../CIShell"
CISHELL_REFERENCE_GUI="${CISHELL_APPS}/../cishell-reference-gui"
CISHELL_PLUGINS="${CISHELL_APPS}/../cishell-plugins"

if [[ ! -e $CISHELL_CORE ]] || [[ ! -e $CISHELL_PLUGINS ]] || [[ ! -e $CISHELL_REFERENCE_GUI ]]; then
  echo "The default build script assumes CIShell, cishell-reference-gui, cishell-plugins, and cishell-apps are all in the same directory."
  exit 1
fi

if [ "$1" == "clean" ]; then
  clean="clean"
else
  clean=""
fi

if [ "$clean" == "clean" ]; then
  rm -rf dist
fi

mopts="${clean}"

pushd ${CISHELL_CORE}
   mvn $mopts install
popd

pushd ${CISHELL_REFERENCE_GUI}
  mvn $mopts install
  mkdir -p ${CISHELL_APPS}/dist/cishell
  cp -r deployment/org.cishell.p2/build/test/cishell/p2 ${CISHELL_APPS}/dist/cishell/
  cp -r deployment/org.cishell.reference.releng/build/test/cishell/* ${CISHELL_APPS}/dist/cishell/
popd

pushd ${CISHELL_PLUGINS}
   mvn $mopts install
popd

pushd ${CISHELL_APPS}
  mvn $mopts install
  mkdir -p dist/sci2
  cp -r sci2/deployment/edu.iu.sci2.p2/build/test/sci2/p2 dist/sci2/
  cp -r sci2/deployment/edu.iu.sci2.releng/build/test/sci2/* dist/sci2/
popd