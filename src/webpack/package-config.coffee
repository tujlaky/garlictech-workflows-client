fs = require 'fs'
path = require 'path'
_ = require 'lodash'

module.exports = (dirname, PATHS) ->
  packageConfig = JSON.parse(fs.readFileSync("#{dirname}/package.json", 'utf8'))
  template = path.join PATHS.src, 'index.html'
  commonsName = 'commons'
  contentBase = PATHS.src

  if packageConfig.garlic?.type is 'module'
    template = path.join PATHS.test, 'index.html'
    contentBase = PATHS.test

  moduleName: packageConfig.name
  template: template
  commonsName: commonsName
  commonsBundleName: "#{packageConfig.name}.#{commonsName}.bundle.js"
  contentBase: contentBase
  commons: _.keys packageConfig.dependencies
