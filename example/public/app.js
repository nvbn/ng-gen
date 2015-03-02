angular.module('app', ['ng-gen'])

    .constant('disabledGenres', ['comedy'])

    .controller('mainCtrl', function ($scope, $http, gen, mainGen, wait, disabledGenres) {
        var getMovies = function (genre) {
            return gen(function*() {
                if (!genre) genre = '';
                var response = yield $http.get('/movies/?genre=' + genre);
                return response.data;
            })
        };

        var getGenres = function () {
            return gen(function*() {
                var genres = yield $http.get('/genres/?legacy=true');
                return genres.data.filter(function (genre) {
                    return disabledGenres.indexOf(genre) == -1;
                });
            })
        };

        $scope.setGenre = function (genre) {
            return gen(function*() {
                if (genre === $scope.currentGenre) {
                    $scope.currentGenre = '';
                } else {
                    $scope.currentGenre = genre;
                }
                $scope.movies = yield getMovies($scope.currentGenre);
            });
        };

        mainGen(function*() {
            try {
                $scope.genres = yield getGenres();
                $scope.movies = yield getMovies();
            } catch (err) {
                console.error("Can't fetch data", err);
            }

            $scope.currentGenre = '';

            while (true) {
                yield wait(10000);

                try {
                    $scope.movies = yield getMovies($scope.currentGenre);
                } catch (err) {
                    console.log("Can't get movies:", err);
                }
            }
        });
    });
