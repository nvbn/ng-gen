describe 'gen', ->
  [gen, $q] = []

  beforeEach ->
    module 'ng-gen'
    inject ($injector) ->
      gen = $injector.get 'gen'
      $q = $injector.get '$q'

  it 'should work with successful promise', genTest ->
    result = yield $q (resolve) -> resolve 'test'
    expect(result).toBe 'test'

  it 'should work with rejected promise', genTest ->
    try
      yield $q (_, reject) -> reject 'error'
    catch err
      expect(err).toBe 'error'

  it 'should be promise', genTest ->
    promise = gen ->
      if false  # for making this function a generator
        yield 1
      'test'
    expect(promise.then).not.toBeUndefined()
    value = yield promise
    expect(value).toBe 'test'

  it 'should be rejected on exception', genTest ->
    try
      yield gen ->
        if false  # for making this function a generator
          yield 1
        throw "error"
    catch err
      expect(err).toBe 'error'

  it 'should be rejected when not promise yielded', genTest ->
    try
      yield gen -> yield 1
    catch err
      expect(err.message).toBe 'gen works only with promises'

describe 'wait', ->
  wait = undefined

  beforeEach ->
    module 'ng-gen'
    inject ($injector) ->
      wait = $injector.get 'wait'

  it 'should wait and continue', genTest ->
    yield wait 100
