gen = angular.module 'ng-gen', []

gen.factory 'gen', ($q) -> (fn) ->
  $q (resolve, reject) ->
    generator = fn()

    putInGenerator = (method) -> (val) ->
      try
        handlePromise generator[method](val)
      catch error
        reject error

    handlePromise = ({value, done}) ->
      if done
        resolve value
      else if value and value.then
        value.then putInGenerator('next'), putInGenerator('throw')
      else
        reject Error 'gen works only with promises'

    handlePromise generator.next()

gen.factory 'mainGen', (gen) -> (fn) ->
  gen(fn).then (->), (err) -> throw err

gen.factory 'wait', ($timeout) -> (delay) ->
  $timeout (->), delay
