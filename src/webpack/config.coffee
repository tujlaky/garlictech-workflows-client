_ = require 'lodash'
fs = require 'fs'
path = require 'path'

module.exports = (dirname) ->
  commonConfig = (require './common') dirname
  packageConfig = require('./package-config') dirname, commonConfig.paths
  
  conf = _.assign commonConfig.config,
    entry:
      release: './src/'
    output:
      path: commonConfig.paths.dist
      filename: "#{packageConfig.moduleName}.[name].bundle.js"
      sourceMapFilename: "[file].map"
      chunkFilename: '[id].bundle.js'

    cache: true

    devServer:
      contentBase: packageConfig.contentBase
      content: "index.html"
      modules: true
      reasons: true
      errorDetails: true
      hot: true
      colors: true
      port: 8081
      host: '0.0.0.0'

  conf.entry[packageConfig.commonsName] = packageConfig.commons

  if process.env.NODE_ENV is 'development'
    conf.entry.e2e = './e2e/test-app'

  return conf
