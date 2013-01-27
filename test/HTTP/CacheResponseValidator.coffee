{should} = require '../utils'

describe 'CacheResponseValidator', () ->
  CacheResponseValidator = require '../../like/HTTP/CacheResponseValidator'

  ####

  it 'should not store if private', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Cache-Control': 'private'
    }).canStore.should.eql false

  it 'should not store if no-store', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Cache-Control': 'no-store'
    }).canStore.should.eql false

  it 'should not store if max-age is not positive', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Cache-Control': 'max-age=0'
    }).canStore.should.eql false

    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Cache-Control': 'max-age=-1'
    }).canStore.should.eql false

  it 'should not store if status is not cacheable', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      statusCode: 201
    }).canStore.should.eql false

  it 'should store if max-age is positive', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Cache-Control': 'max-age=1'
    }).canStore.should.eql true

  it 'should store if has expires', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Expires': new Date().toUTCString()
    }).canStore.should.eql true

  it 'should store if has last-modified', () ->
    v = new CacheResponseValidator
    v.test({
      method: 'GET'
      url: 'http://example.com'
    }, {
      headers:
        'Last-Modified': new Date().toUTCString()
    }).canStore.should.eql true
