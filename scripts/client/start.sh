#!/usr/bin/env bash

[ "$NODE_ENV" == "development" ] && FLAGS="--inline --hot --watch"
node ${WORKFLOWS_BIN}/webpack-dev-server $FLAGS