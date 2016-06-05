#!/usr/bin/env bash

[ "$NODE_ENV" == "development" ] && FLAGS="--inline --hot --watch"

node ${KARMA_ROOT}/karma start