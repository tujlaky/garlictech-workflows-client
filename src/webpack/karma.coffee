webpack = require 'webpack'
plugins = require('webpack-load-plugins')()

IsDev = process.env.NODE_ENV is 'development'

module.exports = (dirname) ->
  commonConfig = (require './common') dirname
  PATHS = commonConfig.paths
  packageConfig = require('./package-config') dirname, PATHS
  
  (config) ->
    # The statically settable properties. We set more properties programmatically after that
    result =
      files: [
        packageConfig.main
        packageConfig.unittest
      ]

      watched: IsDev
      included: true
      served: true
      singleRun: not IsDev

      preprocessors: {}
      
      webpack: commonConfig.config

      webpackMiddleware:
        stats:
          colors: true

      autoWatch : true
      colors: true
      logLevel: "debug"
      frameworks: ['mocha', 'sinon-chai']
      # browsers : ['Chrome']
      browsers: ['PhantomJS_custom']
      captureTimeout: 60000
      reportSlowerThan: 500

      customLaunchers:
        'PhantomJS_custom':
          base: 'PhantomJS'
          options:
            windowName: 'my-window'
            settings:
              webSecurityEnabled: false
          flags: ['--load-images=true']

      phantomjsLauncher:
        exitOnResourceError: true

      plugins : [
        # 'karma-chrome-launcher',
        'karma-phantomjs-launcher',
        'karma-mocha',
        'karma-mocha-reporter',
        'karma-sinon-chai',
        'karma-webpack',
        # 'karma-coverage'
      ]

      reporters: ['mocha']
      # reporters: ['mocha', 'coverage']

      client:
        chai:
          includeStack: true

    result.preprocessors[packageConfig.main] = ['webpack']
    result.preprocessors[packageConfig.unittest] = ['webpack']

    result.webpack.plugins.push new webpack.ProvidePlugin
      GarlicTest: '@garlictech/workflows-client/src/test/unit'

    config.set result
    return config

