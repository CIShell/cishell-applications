#!/bin/bash
set -e

CISHELL_APPS=`cd $(dirname $0); pwd`
CISHELL_CORE="${CISHELL_APPS}/../CIShell"
CISHELL_REFERENCE_GUI="${CISHELL_APPS}/../cishell-reference-gui"
CISHELL_PLUGINS="${CISHELL_APPS}/../cishell-plugins"

if [ "$1" != "" ]; then
  CISHELL_CORE=$1
else
  echo "The default build script assumes CIShell, cishell-reference-gui, cishell-plugins, and cishell-apps are all in the same directory."
fi

if [ "$2" != "" ]; then
  CISHELL_REREFENCE_GUI=$2
fi

if [ "$3" != "" ]; then
  CISHELL_PLUGINS=$3
fi

pushd ${CISHELL_CORE}
   mvn clean install
popd

pushd ${CISHELL_PLUGINS}
   mvn clean install
popd

pushd ${CISHELL_REFERENCE_GUI}
  mvn clean install -P build-nonpde
  mvn clean install

  ant -f deployment/org.cishell.reference.releng/postMavenTasks.xml build deploy
  ant -f deployment/org.cishell.p2/p2-ant-tasks.xml deploy-dev-p2

  mkdir -p ${CISHELL_APPS}/dist/cishell
  cp -r deployment/org.cishell.p2/build/test/cishell/p2 ${CISHELL_APPS}/dist/cishell/
  cp -r deployment/org.cishell.reference.releng/build/test/cishell/* ${CISHELL_APPS}/dist/cishell/
popd

pushd ${CISHELL_APPS}
  mvn clean install -P build-nonpde
  mvn clean install

  # NOTE: NWB and Epic have not been converted as of Dec 2017.
  ant -f sci2/deployment/edu.iu.sci2.releng/postMavenTasks.xml build deploy
  ant -f sci2/deployment/edu.iu.sci2.p2/p2-ant-tasks.xml deploy-dev-p2

  # Copy built diles to dist/sci2
  mkdir -p dist/sci2
  cp -r sci2/deployment/edu.iu.sci2.p2/build/test/sci2/p2 dist/sci2/
  cp -r sci2/deployment/edu.iu.sci2.releng/build/test/sci2/* dist/sci2/
popd
