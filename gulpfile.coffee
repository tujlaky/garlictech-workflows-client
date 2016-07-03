gulp = require 'gulp'

config =
  base: __dirname

gulp = require("./src/gulp/dev")(gulp, config)
