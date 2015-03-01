gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
karma = require 'karma'

gulp.task 'build', ->
  gulp.src './src/*.coffee'
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe sourcemaps.write '.'
  .pipe gulp.dest './dist'

gulp.task 'runTest', (done) ->
  karma.server.start
    configFile: __dirname + '/karma.conf.coffee'
    singleRun: true
  , done

gulp.task 'buildTest', ->
  gulp.src './tests/src/*.coffee'
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe sourcemaps.write '.'
  .pipe gulp.dest './tests/build'

gulp.task 'test', ->
  runSequence ['build', 'buildTest'], 'runTest'

gulp.task 'default', ['build']
