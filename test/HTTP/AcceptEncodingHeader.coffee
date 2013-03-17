{should} = require '../utils'

describe 'AcceptEncodingHeader', () ->
  AcceptEncodingHeader = require '../../like/HTTP/AcceptEncodingHeader'

  ####

  it 'should parse a simple encoding correctly', () ->
    h = new AcceptEncodingHeader '  gzip  '
    h.tokens.should.eql [
      {encoding:'gzip'}
    ]

    h = new AcceptEncodingHeader 'gzip,deflate,sdch'
    h.tokens.should.eql [
      {encoding:'gzip'},
      {encoding:'deflate'}
      {encoding:'sdch'}
    ]
