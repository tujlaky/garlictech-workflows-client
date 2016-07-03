module.exports = (_gulp, config) ->

  gulp = require('gulp-help') _gulp

  require('@garlictech/workflows-common/dist/gulp/client')(gulp, config)

  return gulp
