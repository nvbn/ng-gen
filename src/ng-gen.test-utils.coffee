window.genTest = (fn) -> (done) -> inject ($injector, _$rootScope_) ->
  $injector.get('gen')(fn).then (-> done()), (err) -> throw err
  $injector.get('$timeout').flush()
  _$rootScope_.$apply()
