{should} = require '../utils'

describe 'CacheResponseValidator', () ->
  CacheResponseValidator = require '../../like/HTTP/CacheResponseValidator'

  ####

  it 'should not store if private', () ->
    v = new CacheResponseValidator
    v.test({}, {
      headers:
        'Cache-Control': 'private'
    }).store.should.eql false

  it 'should not store if no-store', () ->
    v = new CacheResponseValidator
    v.test({}, {
      headers:
        'Cache-Control': 'no-store'
    }).store.should.eql false

  it 'should not store if max-age is not positive', () ->
    v = new CacheResponseValidator
    v.test({}, {
      headers:
        'Cache-Control': 'max-age=0'
    }).store.should.eql false

    v.test({}, {
      headers:
        'Cache-Control': 'max-age=-1'
    }).store.should.eql false

  it 'should not store if status is not cacheable', () ->
    v = new CacheResponseValidator
    v.test({}, {
      statusCode: 201
    }).store.should.eql false

  it 'should store if max-age is positive', () ->
    v = new CacheResponseValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
    }, {
      headers:
        'Cache-Control': 'max-age=1'
    }).store.should.eql true

  it 'should store if has expires', () ->
    v = new CacheResponseValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
    }, {
      headers:
        'Expires': new Date().toUTCString()
    }).store.should.eql true

  it 'should store if has last-modified', () ->
    v = new CacheResponseValidator
    v.test({
      url: 'http://example.com'
      method: 'GET'
    }, {
      headers:
        'Last-Modified': new Date().toUTCString()
    }).store.should.eql true
