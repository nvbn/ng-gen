# ng-gen

Angular module for replacing callbacks with es6 generators. Inspired by [tornado.gen](http://tornado.readthedocs.org/en/latest/gen.html).

## Usage

Install `ng-gen` from bower:

```bash
bower install ng-gen
```

Add `ng-gen.js` as a script:

```html
<script type='text/javascript' src='components/ng-gen/dist/ng-gen.js' />
```

Add `ng-gen` as a module to your app:

```javascript
ng.module('app', ['ng-gen'])
```

Use it:

```javascript
.controller(($scope, $http, gen, wait) => {
  $scope.movies = gen(function*(){
    // Handles only success branch of promise:
    let {data: newMovies} = yield $http.get('/new-movies/');

    yield wait(1000);

    // Handles success and error branch of promise:
    try {
      let {data: seenMovies} = yield $http.get('/seen-movies/');
    } catch (err) {
      let seenMovies = [];
    }

    // Result of gen is a promise:
    return newMovies.concat(seenMovies);
  });
});
```

For tests `ng-gen` has a helper script `ng-gen.test-utils.js`, with it tests will be like:

```javascript
it('Sums number', genTest(function*(){
  let val = yield sum(1, 2);
  expect(val).toBe(3);
}));
```

This library also works with coffeescript generators.
