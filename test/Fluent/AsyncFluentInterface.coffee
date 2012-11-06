{_, should} = require '../utils'

describe 'AsyncFluentInterface', () ->
  AsyncFluentInterface = require '../../like/Fluent/AsyncFluentInterface'
  expectedStack = [1,2,3]
  notExpectedStack = [4,5,6]
  expectedContext = {test:true}
  callFunAsync = (fun, context, args, callback) ->
    setTimeout () =>
      try
        result = fun.apply context, args
      catch e
        return callback e
      callback null, result


  class A extends AsyncFluentInterface
    _chainableActions: [
      'asyncFunA'
      'asyncFunB'
    ]

    ####

    syncFunA: (stack) ->
      @pushStack stack

    asyncFunA: (stack, callback) ->
      {next, err, resp} = callback
      return next err  if err
      callFunAsync @syncFunA, @, [stack], next

    syncFunB: (stack) ->
      result = @pushStack stack
      result

    asyncFunB: (stack, callback) ->
      {next, err, resp} = callback
      return next err  if err
      callFunAsync @syncFunB, @, [stack], next


  it 'should support basic sync functionality', () ->
    a = new A
    a.syncFunA(expectedStack).get().should.eql expectedStack


  it 'should support basic async functionality', (done_) ->
    done = (err) ->
      done.count--
      done_ err  if err or done.count is 0
    done.count = 2

    a = new A
    a.asyncFunA(expectedStack).callback (err, resp) ->
      return done err  if err
      resp.get().should.eql expectedStack
      @get().should.eql expectedStack
      done()

    b = new A
    b.asyncFunA(expectedStack).callback (err, resp) ->
      return done err  if err
      resp.get().should.eql expectedStack
      @get().should.eql expectedStack
      done()


  it 'should implement chained async functionality', (done) ->
    a = new A()
    a.asyncFunB notExpectedStack

    a.asyncFunA(expectedStack).callback (err, resp) ->
      return done err  if err
      resp.get().should.eql expectedStack
      @get().should.eql expectedStack
      done()


  it 'should allow for chained async functionality inside the callback', (done) ->
    a = new A()
    a

    a.asyncFunB(notExpectedStack).callback (err, resp) ->
      return done err  if err
      @.asyncFunB(expectedStack).callback (err, resp) ->
        return done err  if err
        resp.get().should.eql expectedStack
        @get().should.eql expectedStack
        done()


  describe '.get()', () ->
    it 'should return the stack as callback\'s resp', (done) ->
      a = new A()
      a.asyncFunB(notExpectedStack).asyncFunA(expectedStack).get().callback (err, resp) ->
        return done err  if err
        resp.should.eql expectedStack
        @get().should.eql expectedStack
        done()


  describe '.each()', () ->
    it 'should return the iterator\'s resp as an array in callback\'s resp', (done) ->
      a = new A()
      iterator = (next, elem) ->
        next null, elem-3
      a.asyncFunA(notExpectedStack).each(iterator).callback (err, resp) ->
        done err  if err
        resp.should.eql expectedStack
        @get().should.eql notExpectedStack
        done()


  describe '.map()', () ->
    it 'should return the iterator\'s resp as an array in callback\'s resp, and as the new stack', (done) ->
      a = new A()
      iterator = (next, elem) ->
        next null, elem-3
      a.asyncFunA(notExpectedStack).map(iterator).callback (err, resp) ->
        done err  if err
        resp.should.equal @
        @get().should.eql expectedStack
        done()


  describe '.promise()', () ->
    it 'should return a jQuery-like promise', (done_) ->
      done = (err) ->
        done.count--
        done_ err  if err or done.count is 0
      done.count = 2

      a = new A()
      a.asyncFunB(notExpectedStack).asyncFunA(expectedStack).promise()
        .fail((err) ->
          done err
        ).done((resp) ->
          resp.get().should.eql expectedStack
          done()
        )

      b = new A()
      b.asyncFunB(notExpectedStack).asyncFunA(expectedStack).get().promise()
        .fail((err) ->
          done err
        ).done((resp) ->
          resp.get().should.eql expectedStack
          done()
        )



  # it 'asdas', () ->
  #   return
  #   re$('root').read().followLink('checkout.orders').create({cart: {}, address: {}}).get (err, resp) =>
  #     {request, response, body} = resp

  #   re$('checkout.order', URI).read().prop('/merchant_reference').get()
  #     .done((resp) =>
  #       console.log resp # {'orderid1': '1234567890'}
  #     ).fail((err) =>
  #       console.log err
  #     )

  #   re$('checkout.order', URI).read().prop('/merchant_reference').get (err, resp) =>
  #     console.log resp # {'orderid1': '1234567890'}

  #   re$('checkout.order').read().followLink('backoffice.order').read().get '/status', (err, resp) =>
  #     console.log resp # 'created'

  #   re$('backoffice.orders').read().followLinks('item').read().get '/status', (err, resp) =>
  #     console.log resp # ['created', 'created']
