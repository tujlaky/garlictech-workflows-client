#!/usr/bin/env bash

[ "$NODE_ENV" == "development" ] && FLAGS="--inline --hot --watch"
node ${WEBPACK_ROOT}/webpack-dev-server $FLAGS