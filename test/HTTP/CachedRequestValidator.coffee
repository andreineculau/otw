{should} = require '../utils'

describe 'CachedRequestValidator', () ->
  CachedRequestValidator = require '../../like/HTTP/CachedRequestValidator'

  ####

  it 'should not retrieve if max-age is not positive', () ->
    v = new CachedRequestValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
      headers:
        'Cache-Control': 'max-age=0'
    }).retrieve.should.eql false

    v.test({
      url: 'http://example.com'
      method: 'GET'
      headers:
        'Cache-Control': 'max-age=-1'
    }).retrieve.should.eql false

  it 'should not retrieve if no-cache', () ->
    v = new CachedRequestValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
      headers:
        'Cache-Control': 'no-cache'
    }).retrieve.should.eql false

    v.test({
      url: 'http://example.com'
      method: 'GET'
      headers:
        'Pragma': 'no-cache'
    }).retrieve.should.eql false

  it 'should not retrieve if no-store', () ->
    v = new CachedRequestValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
      headers:
        'Cache-Control': 'no-store'
    }).retrieve.should.eql false

  it 'should retrieve if method is safe', () ->
    v = new CachedRequestValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
    }).retrieve.should.eql true

    v.test({
      url: 'http://example.com'
      method: 'HEAD'
    }).retrieve.should.eql true

  it 'should not retrieve if method is not safe', () ->
    v = new CachedRequestValidator
    v.test({
      url: 'http://example.com'
      method: 'POST'
    }).retrieve.should.eql false
