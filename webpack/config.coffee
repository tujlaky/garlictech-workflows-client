_ = require 'lodash'
fs = require 'fs'
path = require 'path'

module.exports = (dirname, isComponent = true) ->
  commonConfig = (require './common')(dirname, isComponent)
  PATHS = commonConfig.paths

  moduleTypeConfig = if isComponent
    contentBase: PATHS.test
  else
    contentBase: PATHS.src

  moduleName = JSON.parse(fs.readFileSync("#{dirname}/package.json", 'utf8')).name
  
  _.assign commonConfig.config,
    entry:
      release: './src/'
      e2e: './e2e/test-app'
      vendor: './src/vendor'
    output:
      path: PATHS.dist
      filename: "#{moduleName}.[name].bundle.js"
      sourceMapFilename: "[file].map"
      chunkFilename: '[id].bundle.js'

    cache: true

    devServer:
      contentBase: moduleTypeConfig.contentBase
      content: "index.html"
      modules: true
      reasons: true
      errorDetails: true
      hot: true
      colors: true
      port: 8081
      host: '0.0.0.0'

