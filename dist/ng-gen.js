(function() {
  var gen;

  gen = angular.module('ng-gen', []);

  gen.factory('gen', function($rootScope, $q) {
    return function(fn) {
      return $q(function(resolve, reject) {
        var generator, handlePromise, putInGenerator;
        generator = fn();
        putInGenerator = function(method) {
          return function(val) {
            var error;
            try {
              return handlePromise(generator[method](val));
            } catch (_error) {
              error = _error;
              return reject(error);
            }
          };
        };
        handlePromise = function(arg) {
          var done, value;
          value = arg.value, done = arg.done;
          if (done) {
            return resolve(value);
          } else if (value && value.then) {
            return value.then(putInGenerator('next'), putInGenerator('throw'));
          } else {
            return reject(Error('gen works only with promises'));
          }
        };
        return handlePromise(generator.next());
      });
    };
  });

  gen.factory('wait', function($timeout) {
    return function(delay) {
      return $timeout((function() {}), delay);
    };
  });

}).call(this);

//# sourceMappingURL=ng-gen.js.map