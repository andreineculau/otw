{should} = require '../utils'

describe 'AcceptLanguageHeader', () ->
  AcceptLanguageHeader = require '../../like/HTTP/AcceptLanguageHeader'

  ####

  it 'should parse a simple languages correctly', () ->
    h = new AcceptLanguageHeader '  en  '
    h.tokens.should.eql [
      {lang:'en'}
    ]

    h = new AcceptLanguageHeader 'en, sv'
    h.tokens.should.eql [
      {lang:'en'},
      {lang:'sv'}
    ]


  it 'should parse complex languages with parameters correctly', () ->
    h = new AcceptLanguageHeader 'en-US;q=0.8,en;Q=0.5,sv-SE'
    h.tokens.should.eql [
      {lang:'en-us',q:'0.8'}
      {lang:'en',q:'0.5'}
      {lang:'sv-se'}
    ]

