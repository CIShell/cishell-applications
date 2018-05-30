#!/bin/bash
set -e

CISHELL_APPS=$(dirname $0)
CISHELL_CORE="${CISHELL_APPS}/../CIShell"
CISHELL_REREFENCE_GUI="${CISHELL_APPS}/../cishell-reference-gui"
CISHELL_PLUGINS="${CISHELL_APPS}/../cishell-plugins"

if [ "$1" != "" ]; then
  CISHELL_CORE=$1
else
  echo "The default build script assumes CIShell, cishell-plugins, and cishell-apps are all in the same directory."
fi

if [ "$2" != "" ]; then
  CISHELL_REREFENCE_GUI=$2
fi

if [ "$3" != "" ]; then
  CISHELL_PLUGINS=$3
fi

for repo in "${CISHELL_CORE} ${CISHELL_REREFENCE_GUI} ${CISHELL_PLUGINS} ${CISHELL_APPS}"; do
  pushd $repo
    mvn -Pbuild-nonpde clean install
    mvn -o clean install
  popd
done

pushd $CISHELL_APPS
  # NWB and Epic have not been converted as of Dec 2017.
  mkdir -p dist/sci2
  ant -f sci2/deployment/edu.iu.sci2.releng/postMavenTasks.xml build deploy
  ant -f sci2/deployment/edu.iu.sci2.p2/p2-ant-tasks.xml deploy-dev-p2

  # Copy built diles to dist/sci2
  cp -r sci2/deployment/edu.iu.sci2.p2/build/test/sci2/p2 dist/sci2/
  cp -r sci2/deployment/edu.iu.sci2.releng/build/test/sci2/* dist/sci2/
popd
