{should} = require '../utils'

describe 'AcceptHeader', () ->
  AcceptHeader = require '../../like/HTTP/AcceptHeader'

  ####

  it 'should parse a simple media-types correctly', () ->
    h = new AcceptHeader '  application/json  '
    h.tokens.should.eql [
      {mediaType:'application/json',type:'application',subtype:'json',syntax:'json'}
    ]

    h = new AcceptHeader 'application/json, application/xml'
    h.tokens.should.eql [
      {mediaType:'application/json',type:'application',subtype:'json',syntax:'json'}
      {mediaType:'application/xml',type:'application',subtype:'xml',syntax:'xml'}
    ]


  it 'should parse a media-types as case-insensitive', () ->
    h = new AcceptHeader 'application/JSON;Q=1.0;CharSet=Utf-8'
    h.tokens.should.eql [
      {mediaType:'application/json',type:'application',subtype:'json',syntax:'json',q:'1.0',charset:'utf-8'}
    ]


  it 'should parse custom media-types with parameters correctly', () ->
    h = new AcceptHeader 'application/vnd.custom-v1+json ;test=true; 123=qwe, application/vnd.custom-v1+xml;test=false;456=qwe'
    h.tokens.should.eql [
      {mediaType:'application/vnd.custom-v1+json',type:'application',subtype:'vnd.custom-v1+json',syntax:'json',test:'true',123:'qwe'}
      {mediaType:'application/vnd.custom-v1+xml',type:'application',subtype:'vnd.custom-v1+xml',syntax:'xml',test:'false',456:'qwe'}
    ]


  it 'should parse complex media-types with parameters correctly', () ->
    h = new AcceptHeader 'application/vnd.custom.json;  "test"  =true;"test"=false'
    h.tokens.should.eql [
      {mediaType:'application/vnd.custom.json',type:'application',subtype:'vnd.custom.json','"test"':'true'}
    ]


  it 'should be able to stringify correctly', () ->
    h = new AcceptHeader 'application/vnd.custom-v1+json;test=true;123=qwe,application/vnd.custom-v1+xml;test=false;456=qwe'
    h.toString().should.equal 'application/vnd.custom-v1+json;123=qwe;test=true,application/vnd.custom-v1+xml;456=qwe;test=false'


  it 'should choose token handler correctly', () ->
    h = new AcceptHeader 'application/json;charset=utf-8, application/xml;q=0.5, */*;q=0.1'
    tokenHandlerList = [
      {token: 'application/json;charset=*', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'application/json;charset=*'
    chosen.best.score.should.equal 0.96
    chosen.best.unmatchedParams.should.eql {}

    h = new AcceptHeader 'application/json;charset=utf-8, application/xml;q=0.5, */*;q=0.1'
    tokenHandlerList = [
      {token: 'application/json;charset=*;q=0.5', handler: () ->}
      {token: 'application/json;charset=*;q=0.9', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'application/json;charset=*;q=0.9'
    chosen.best.score.should.equal 0.96
    chosen.best.unmatchedParams.should.eql {}

    h = new AcceptHeader 'application/json;charset=utf-8, application/xml;q=0.5, */*;q=0.1'
    tokenHandlerList = [
      {token: 'application/json;charset=utf-8', handler: () ->}
      {token: 'application/xml', handler: () ->}
      {token: 'text/plain', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'application/json;charset=utf-8'
    chosen.best.score.should.equal 1
    chosen.best.unmatchedParams.should.eql {}

    tokenHandlerList = [
      {token: 'application/xml', handler: () ->}
      {token: 'text/plain', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'application/xml'
    chosen.best.score.should.equal 1
    chosen.best.unmatchedParams.should.eql {}

    tokenHandlerList = [
      {token: 'text/html', handler: () ->}
      {token: 'text/plain', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'text/html'
    chosen.best.score.should.equal 0.31
    chosen.best.unmatchedParams.should.eql {}
