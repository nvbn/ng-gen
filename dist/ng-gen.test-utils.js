(function() {
  window.genTest = function(fn) {
    return function(done) {
      return inject(function($injector, _$rootScope_) {
        $injector.get('gen')(fn).then((function() {
          return done();
        }), function(err) {
          throw err;
        });
        $injector.get('$timeout').flush();
        return _$rootScope_.$apply();
      });
    };
  };

}).call(this);

//# sourceMappingURL=ng-gen.test-utils.js.map