_ = require 'lodash'
fs = require 'fs'
path = require 'path'
webpack = require 'webpack'
plugins = require('webpack-load-plugins')()

module.exports = (dirname) ->
  commonConfig = (require './common') dirname
  packageConfig = require('./package-config') dirname, commonConfig.paths
  
  conf = _.assign commonConfig.config,
    entry:
      release: './src/'
      e2etest: './e2e/test-app'
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
      port: process.env.npm_package_config_port or 8081
      host: '0.0.0.0'

  conf.entry[packageConfig.commonsName] = packageConfig.commons
  conf.plugins.push new webpack.optimize.CommonsChunkPlugin packageConfig.commonsName, packageConfig.commonsBundleName

  return conf
