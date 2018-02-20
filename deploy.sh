#!/bin/bash

export PORT=6000
export MIX_ENV=prod
export GIT_PATH=/data/www/hw06/tasktrack

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktrack ]; then
	echo mv ~/www/tasktrack ~/old/$NOW
	mv ~/www/tasktrack ~/old/$NOW
fi

mkdir -p ~/www/tasktrack
REL_TAR=/data/www/hw06/tasktrack/_build/prod/rel/tasktrack/releases/0.0.1/tasktrack.tar.gz
(cd ~/www/tasktrack && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /data/www/hw06/tasktrack/start.sh
CRONTAB

#. start.sh
