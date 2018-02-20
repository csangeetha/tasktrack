#!/bin/bash

export PORT=6000

cd ~/www/tasktrack
./bin/tasktrack stop || true
./bin/tasktrack start
