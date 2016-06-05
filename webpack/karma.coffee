_ = require 'lodash'
webpack = require 'webpack'
path = require 'path'

IsDev = process.env.NODE_ENV is 'development'

module.exports = (dirname) ->
  commonConfig = (require './common')(dirname)
  PATHS = commonConfig.paths
  
  (config) ->
    config.set
      files: [
        "src/test/unit/test.coffee",
        "./src/index.coffee",
        "./src/vendor.coffee"
      ]

      watched: IsDev
      included: true
      served: true
      singleRun: not IsDev

      preprocessors:
        "src/test/unit/test.coffee": ['webpack']
        "./src/index.coffee": ['webpack']
        "./src/vendor.coffee": ['webpack']
      
      webpack: commonConfig.config

      webpackMiddleware:
        stats:
          colors: true

      autoWatch : true
      colors: true
      logLevel: "debug"
      frameworks: ['mocha', 'chai-sinon', 'chai-as-promised', 'sinon']
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
        'karma-chai-sinon',
        'karma-sinon',
        'karma-mocha-reporter',
        'karma-webpack',
        # 'karma-coverage'
        'karma-chai-plugins',
      ]

      reporters: ['mocha']
      # reporters: ['mocha', 'coverage']