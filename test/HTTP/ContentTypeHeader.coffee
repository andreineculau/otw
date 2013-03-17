{should} = require '../utils'

describe 'ContentTypeHeader', () ->
  ContentTypeHeader = require '../../like/HTTP/ContentTypeHeader'

  ####

  it 'should parse a simple Content-Type header correctly', () ->
    h = new ContentTypeHeader 'application/json'
    h.tokens.should.eql [
      {mediaType:'application/json',type:'application',subtype:'json',syntax:'json'}
    ]

    h = new ContentTypeHeader 'application/json,application/xml'
    h.tokens.should.eql [
      {mediaType:'application/json',type:'application',subtype:'json',syntax:'json'}
    ]


  it 'should be able to stringify correctly', () ->
    h = new ContentTypeHeader 'application/vnd.custom-v1+json;test=true;123=qwe;123=asd,application/vnd.custom-v1+xml;test=false;456=qwe'
    h.toString().should.equal 'application/vnd.custom-v1+json;123=qwe;test=true'
