var
  autoprefixer = require('gulp-autoprefixer'),
  browsersync  = require('browser-sync').create(),
  concat       = require('gulp-concat'),
  gulp         = require('gulp'),
  sass         = require('gulp-sass'),
  sourcemaps   = require('gulp-sourcemaps'),
  uglify       = require('gulp-uglify'),
  dev          = {
    css:   './assets/scss/main.scss',
    js: [
           './assets/js/main.js'
    ]
  },
  dist         = {
    root:  './public/',
    css:   './public/css/',
    js:    './public/js/'
  };

gulp.task('scss', function() {
  return gulp
    .src(dev.css)
    .pipe(sourcemaps.init())
    .pipe(sass({outputStyle: 'compressed'}))
    .pipe(autoprefixer())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest(dist.css));
});

gulp.task('js', function() {
  return gulp
    .src(dev.js)
    .pipe(sourcemaps.init())
    .pipe(concat('main.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest(dist.js));
});

gulp.task('watch', function() {
  gulp.watch('./assets/scss/**', ['scss']);
  gulp.watch(dev.js,             ['js']);
});

gulp.task('server', function() {
  browsersync.init({
    server: {
      baseDir: dist.root,
      routes: {
        '/test' : 'js'
      }
    },
    port:   4000,
    notify: false,
    open:   false
  });
});

gulp.task('default', ['scss', 'js', 'watch', 'server']);
