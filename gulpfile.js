var gulp = require("gulp");
var gutil = require("gulp-util");
var webpack = require("webpack");
var browserify = require('browserify');
var shim = require("browserify-shim");
var browserSync = require("browser-sync");
var source = require("vinyl-source-stream");
var exampleWebpackConfig = require("./example/webpack.example.js");

var execWebpack = function(config) {
    webpack((config), function(err, stats) {
        if (err) new gutil.PluginError("execWebpack", err);
        // gutil.log(stats.toString({colors: true}));
    });
}

/* Build /src into dist/talk.js */
gulp.task('build', function() {
    var bundler = browserify({
        entries: ['./src/index.cjsx'], // entry point
        extensions: ['.coffee', '.cjsx']
    }).transform(shim).exclude('react');

    var bundle = function() {
        return bundler
            .bundle()
            .on('error', function(err) {
                gutil.log('browserify error', err);
            })
            .pipe(source('talk.js'))
            .pipe(gulp.dest('dist')) // output destination
    };
    bundle();
});

gulp.task('webpack', function(callback){
    execWebpack(exampleWebpackConfig);
    callback();
});

gulp.task('dev-server', function(){
    browserSync({
        open: false,
        port: 3333,
        logLevel: "debug",
        notify: false,
        server: {
            baseDir: "./example"
        }
    });
});

gulp.task('default', ['webpack', 'dev-server']);
