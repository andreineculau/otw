{should} = require '../utils'
LinkHeader = require '../../like/HTTP/LinkHeader'

describe 'LinkHeader', () ->
  it 'should parse a simple Link header correctly', () ->
    h = new LinkHeader '<https://klarna.com>'
    h.tokens.should.eql [
      {href:'https://klarna.com'}
    ]

    h = new LinkHeader '<https://klarna.com>,<https://google.com>'
    h.tokens.should.eql [
      {href:'https://klarna.com'}
      {href:'https://google.com'}
    ]


  it 'should parse a complex Link header  correctly', () ->
    h = new LinkHeader '<https://klarna.com>; rel=self'
    h.tokens.should.eql [
      {href:'https://klarna.com',rel:'self'}
    ]

    h = new LinkHeader '<https://klarna.com>; rel=self; rel=edit, <https://google.com>; rel="self edit"; method'
    h.tokens.should.eql [
      {href:'https://klarna.com',rel:'self'}
      {href:'https://google.com',rel:'self edit', method:true}
    ]


  it 'should be able to stringify correctly', () ->
    h = new LinkHeader '<https://klarna.com>; rel=self, <https://google.com>; rel="self edit"; method'
    h.toString().should.equal '<https://klarna.com>;rel=self,<https://google.com>;rel="self edit";method'
