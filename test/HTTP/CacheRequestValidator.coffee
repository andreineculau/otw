{should} = require '../utils'

describe 'CacheRequestValidator', () ->
  CacheRequestValidator = require '../../like/HTTP/CacheRequestValidator'

  ####

  it 'should retrieve-TRANSPARENT if max-age is not positive', () ->
    v = new CacheRequestValidator
    res = v.test({
      method: 'GET'
      url: 'http://example.com'
      headers:
        'Cache-Control': 'max-age=0'
    })
    res.canRetrieve.should.eql true
    res.disposition.should.eql 'TRANSPARENT'

    res = v.test({
      method: 'GET'
      url: 'http://example.com'
      headers:
        'Cache-Control': 'max-age=-1'
    })
    res.canRetrieve.should.eql true
    res.disposition.should.eql 'TRANSPARENT'

  it 'should retrieve-TRANSPARENT if no-cache', () ->
    v = new CacheRequestValidator
    res = v.test({
      method: 'GET'
      url: 'http://example.com'
      headers:
        'Cache-Control': 'no-cache'
    })
    res.canRetrieve.should.eql true
    res.disposition.should.eql 'TRANSPARENT'

    res = v.test({
      method: 'GET'
      url: 'http://example.com'
      headers:
        'Pragma': 'no-cache'
    })
    res.canRetrieve.should.eql true
    res.disposition.should.eql 'TRANSPARENT'

  it 'should not retrieve if query', () ->
    v = new CacheRequestValidator
    res = v.test({
      method: 'GET'
      url: 'http://example.com?test=true'
    })
    res.canRetrieve.should.eql false

  it 'should retrieve if method is safe', () ->
    v = new CacheRequestValidator
    res = v.test({
      method: 'HEAD'
      url: 'http://example.com'
    })
    res.canRetrieve.should.eql true

    res = v.test({
      method: 'GET'
      url: 'http://example.com'
    })
    res.canRetrieve.should.eql true

  it 'should not retrieve if method is not safe', () ->
    v = new CacheRequestValidator
    res = v.test({
      method: 'POST'
      url: 'http://example.com'
    })
    res.canRetrieve.should.eql false
