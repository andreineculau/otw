{should} = require '../utils'
AcceptHeader = require '../../like/HTTP/AcceptHeader'

describe 'AcceptHeader', () ->
  it 'should parse a simple media-types correctly', () ->
    h = new AcceptHeader '  application/json  '
    h.tokens.should.eql [
      {mediaType:'application/json',syntax:'json'}
    ]

    h = new AcceptHeader 'application/json, application/xml'
    h.tokens.should.eql [
      {mediaType:'application/json',syntax:'json'}
      {mediaType:'application/xml',syntax:'xml'}
    ]


  it 'should parse custom media-types with parameters correctly', () ->
    h = new AcceptHeader 'application/vnd.custom-v1+json ;test=true; 123=qwe, application/vnd.custom-v1+xml;test=false;456=qwe'
    h.tokens.should.eql [
      {mediaType:'application/vnd.custom-v1+json',syntax:'json',test:'true',123:'qwe'}
      {mediaType:'application/vnd.custom-v1+xml',syntax:'xml',test:'false',456:'qwe'}
    ]


  it 'should parse complex media-types with parameters correctly', () ->
    h = new AcceptHeader 'application/vnd.custom.json;  "test"  =true;"test"=false'
    h.tokens.should.eql [
      {mediaType:'application/vnd.custom.json','"test"':'true'}
    ]

  it 'should be able to stringify correctly', () ->
    h = new AcceptHeader 'application/vnd.custom-v1+json;test=true;123=qwe,application/vnd.custom-v1+xml;test=false;456=qwe'
    h.toString().should.equal 'application/vnd.custom-v1+json;123=qwe;test=true,application/vnd.custom-v1+xml;456=qwe;test=false'
