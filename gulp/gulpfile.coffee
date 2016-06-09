gulp = require 'gulp'
gutil = require 'gutil'
p = require('gulp-load-plugins')() # loading gulp plugins lazily
_ = require 'lodash'
argv = require('yargs').argv
watch = require 'gulp-debounced-watch'

console.log '%%%'

# -----------------------------------------------------------------------------
# Create representation of file/directory structure
serverRoot =  "server"
coffeeFiles = ["#{serverRoot}/**/*.coffee"]
jsFiles = ["#{serverRoot}/**/*.js", "#{serverRoot}/**/*.json"]
tplFiles = "#{serverRoot}/modules/auth/passwordless/template/*.tpl"
buildRoot =  "dist"

handleError = (err) ->
  console.log err.toString()
  @emit 'end'

# -----------------------------------------------------------------------------
# Create a gulp task, and orchestrate it with default functions
GulpSrc = (srcFiles, taskName, srcOptions = {}) ->
  gulp.src srcFiles, srcOptions
  .pipe p.cached taskName
  .pipe p.using {}
  .pipe p.size()

# -----------------------------------------------------------------------------
# handle src coffeescript files: static compilation
gulp.task 'coffee', ->
  GulpSrc coffeeFiles, 'coffee', {base: './'}
  .pipe p.coffeelint()
  .pipe p.coffeelint.reporter()
  .pipe p.coffee(bare:true).on 'error', (err)->p.util.log err;@emit 'end'
  .pipe gulp.dest buildRoot

# -----------------------------------------------------------------------------
gulp.task 'js', ->
  GulpSrc jsFiles, 'js', {base: './'}
  .pipe gulp.dest buildRoot

gulp.task 'tpl', ->
  GulpSrc tplFiles, 'tpl', {base: './'}
  .pipe gulp.dest buildRoot

# -----------------------------------------------------------------------------
gulp.task 'watch', ['build'], ->
  watch coffeeFiles, {debounceTimeout: 1000}, ->
    gulp.start ['coffee', 'unittest']
  watch jsFiles, {debounceTimeout: 1000}, ->
    gulp.start ['js', 'unittest']
  watch tplFiles, {debounceTimeout: 1000}, ->
    gulp.start ['tpl', 'unittest']

# -----------------------------------------------------------------------------
gulp.task 'build', ['js', 'tpl', 'coffee']

# -----------------------------------------------------------------------------
gulp.task 'unittest', ['build'], ->
  gulp.src ["#{serverRoot}/test/unittest/index.coffee", "#{serverRoot}/**/*unit-tests.coffee"], {read: false}
    .pipe p.coffee({bare: true}).on('error', gutil.log)
    .pipe p.mocha
      reporter: 'spec'
      ui: 'bdd'
      recursive: true

# -----------------------------------------------------------------------------
gulp.task 'systemtest', ['build'], ->
  p.env.set NODE_ENV: "test"
  gulp.src ["#{serverRoot}/test/systemtest/index.coffee", "#{serverRoot}/**/*system-tests.coffee", "#{serverRoot}/**/*system-tests.js"], {read: false}
    .pipe p.coffee({bare: true}).on('error', gutil.log)
    .pipe p.mocha
      reporter: 'spec'
      ui: 'bdd'
      recursive: true
    .on 'error', handleError
    .once 'end', -> process.exit()

# -----------------------------------------------------------------------------
# Start the web server
gulp.task 'webserver', ->
  p.nodemon
    script: "#{buildRoot}/server/server.js"

# -----------------------------------------------------------------------------
gulp.task 'default', ['build', 'watch', 'webserver']

module.exports = gulp
