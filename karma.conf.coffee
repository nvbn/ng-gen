module.exports = (config) ->
    config.set
        browsers: ['Chrome']
        frameworks: ['jasmine']
        files: ['bower_components/angular/angular.js',
                'bower_components/angular-mocks/angular-mocks.js',
                'dist/ng-gen.js',
                'dist/ng-gen.test-utils.js',
                'tests/build/*.js']
        plugins: ['karma-chrome-launcher',
                  'karma-jasmine']
