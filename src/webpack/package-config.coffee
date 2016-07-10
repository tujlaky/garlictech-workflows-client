fs = require 'fs'
path = require 'path'
_ = require 'lodash'
require 'colors'

module.exports = (dirname, PATHS) ->
  packageConfig = JSON.parse(fs.readFileSync("#{dirname}/package.json", 'utf8'))
  template = path.join PATHS.src, 'index.html'
  commonsName = 'commons'
  unittestName = 'unittest'
  contentBase = PATHS.src

  if packageConfig.garlic?.type is 'module'
    template = path.join PATHS.test, 'index.html'
    contentBase = PATHS.test

  unittest = if packageConfig.garlic?.unittest?
    packageConfig.garlic.unittest
  else
    console.log "WARNING: garlic.unittest is not set in package.json. Setting to default './src/test/unit/test.coffee'".yellow
    "./src/test/unit/test.coffee"

  moduleName: packageConfig.name ? throw Error "Name field should be present in package.json"
  main: packageConfig.main ? throw Error "Main field should be present in package.json"
  template: template
  unittest: unittest
  commonsName: commonsName
  commonsBundleName: "#{packageConfig.name}.#{commonsName}.bundle.js"
  unittestBundleName: "#{packageConfig.name}.#{unittestName}.bundle.js"
  contentBase: contentBase
  commons: _.keys packageConfig.dependencies
