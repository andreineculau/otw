{should} = require '../utils'

describe 'AcceptCharsetHeader', () ->
  AcceptCharsetHeader = require '../../like/HTTP/AcceptCharsetHeader'

  ####

  it 'should parse a simple charset correctly', () ->
    h = new AcceptCharsetHeader '  utf-8  '
    h.tokens.should.eql [
      {charset:'utf-8'}
    ]

    h = new AcceptCharsetHeader 'ISO-8859-1, utf-8'
    h.tokens.should.eql [
      {charset:'iso-8859-1'},
      {charset:'utf-8'}
    ]


  it 'should parse complex charsets with parameters correctly', () ->
    h = new AcceptCharsetHeader 'ISO-8859-1,utf-8;q=0.7,*;q=0.3'
    h.tokens.should.eql [
      {charset:'iso-8859-1'}
      {charset:'utf-8',q:'0.7'}
      {charset:'*',q:'0.3'}
    ]

