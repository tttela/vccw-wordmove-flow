gulp = require 'gulp'
sync = require 'browser-sync'
mainBowerFiles = require 'main-bower-files'
$ = do require 'gulp-load-plugins'

sources =
  url: 'local.ace.com'
  themeDir: './www/wordpress/wp-content/themes/'
  themeName: '' #wp theme name

  css: '/dist/css'
  js: '/dist/js'
  img: '/dist/img'
  font: '/dist/css/fonts'

  cssDev: '/assets/css'
  jsDev: '/assets/js'
  imgDev: '/assets/img'
  fontDev: '/assets/css/fonts'

gulp.task 'server', ->
  console.log '---------- server task ----------'
  sync.init null,
    proxy: sources.url + '/'

# reload
gulp.task 'reload', ->
  sync.reload()

# sass
gulp.task 'sass', ->
  console.log '---------- sass task ----------'
  $.rubySass sources.themeDir + sources.themeName + sources.cssDev
    .pipe $.plumber()
    .pipe($.pleeease(
      optimizers: minifier: false
      autoprefixer: browsers: [ 'last 2 versions' ,'ie 8','ie 9']))
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.css
    .pipe sync.reload
      stream: true

# coffee
gulp.task 'coffee', ->
  console.log '---------- coffee task ----------'
  gulp.src sources.themeDir + sources.themeName + sources.jsDev + '/*.coffee'
    .pipe $.plumber()
    .pipe $.coffee()
    # .pipe uglify mangle:['jQuery']
    # .pipe uglify()
    .pipe $.concat 'all.js'
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.js
    .pipe sync.reload
      stream: true

# jade
# gulp.task 'jade', ->
#   console.log '---------- jade task ----------'
#   gulp.src(['./src/**/*.jade','!./src/partial/**/*.jade'])
#     .pipe $.plumber()
#     .pipe $.jade
#       pretty: true
#       basedir: __dirname
#     .pipe gulp.dest dir
#     .pipe sync.reload
#       stream: true

#font
gulp.task 'font', ->
  gulp
    .src sources.themeDir + sources.themeName + sources.fontDev + '/**/*'
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.font
    .pipe sync.reload stream:true, once:true

#bower
gulp.task 'BowerJS', ->
  console.log '---------- bower task ----------'
  jsFilter = $.filter '**/*.js'
  gulp
    .src mainBowerFiles()
    .pipe jsFilter
    .pipe $.concat 'lib.js'
    .pipe $.uglify({preserveComments: 'some'})
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.js
    .pipe sync.reload
      stream: true

gulp.task 'BowerCSS', ->
  cssFilter = $.filter '**/*.css'
  scssFilter = $.filter '**/*.scss'
  sassFilter = $.filter '**/*.sass'
  gulp
    .src mainBowerFiles()
    .pipe cssFilter
    .pipe $.rename
      prefix: '_'
      extname: '.scss'
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.cssDev + '/lib/'
    .pipe cssFilter.restore()
    .pipe scssFilter
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.cssDev + '/lib/'
    .pipe cssFilter.restore()
    .pipe sassFilter
    .pipe gulp.dest sources.themeDir + sources.themeName + sources.cssDev + '/lib/'
    .pipe cssFilter.restore()
    .pipe sync.reload
      stream: true

# watch
gulp.task 'watch', ['server'],->
  console.log '---------- watch task ----------'

  gulp.watch sources.themeDir + sources.themeName + sources.cssDev + '/*.scss', ['sass']
  gulp.watch sources.themeDir + sources.themeName + sources.jsDev + '/*.coffee', ['coffee']
  gulp.watch sources.themeDir + sources.themeName + sources.fontDev + '/**/*', ['font']
  # gulp.watch sources.themeDir + sources.themeName +'.jade', ['jade']

  # reload
  # gulp.watch 'build/**/*.html', ['reload']
  gulp.watch sources.themeDir + sources.themeName + sources.css, ['reload']
  gulp.watch sources.themeDir + sources.themeName + sources.js, ['reload']
  gulp.watch sources.themeDir + sources.themeName + '/*.php', ['reload']

# default
gulp.task 'default', ['sass','coffee','BowerJS','BowerCSS','font']