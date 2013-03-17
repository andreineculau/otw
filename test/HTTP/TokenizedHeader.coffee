{should} = require '../utils'

describe 'TokenizedHeader', () ->
  TokenizedHeader = require '../../like/HTTP/TokenizedHeader'

  ####

  it 'should parse headers with one token correctly', () ->
    h = new TokenizedHeader 'test=true'
    h.tokens.should.eql [{test:'true'}]


  it 'should parse non-value tokens into token with Boolean value true', () ->
    h = new TokenizedHeader 'test'
    h.tokens.should.eql [{test:true}]

    h = new TokenizedHeader 'test='
    h.tokens.should.eql [{test:''}]


  it 'should ignore whitespace', () ->
    h = new TokenizedHeader ' test = true '
    h.tokens.should.eql [{test:'true'}]


  it 'should treat token keys as case-insensitive', () ->
    h = new TokenizedHeader 'Test=true;p1=P'
    h.tokens.should.eql [{test:'true',p1:'p'}]


  it 'should parse headers with multiple tokens correctly', () ->
    h = new TokenizedHeader 'test,test=,test=true,test="true"'
    h.tokens.should.eql [{test:true},{test:''},{test:'true'},{test:'true'}]


  it 'should parse headers with multiple tokens with parameters correctly', () ->
    h = new TokenizedHeader 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;p1=1;=1'
    h.tokens.should.eql [{test:true,p1:'1'},{test:'',p1:'1',p2:'1'},{test:'true',p1:'1', '':'1'}]


  it 'should stringify correctly', () ->
    h = new TokenizedHeader 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;p1=2;=1;p3=" qwe  qwe  qwe"'
    h.toString().should.equal 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;=1;p3=" qwe  qwe  qwe"'


  it 'should sort tokens correctly', () ->
    h = new TokenizedHeader 'test=true;q=0.0,test;q=0.75,test=;q=0.99,test'
    h.getSortedTokens().should.eql [
      {test:true}
      {test:'',q:'0.99'}
      {test:true,q:'0.75'}
      {test:'true',q:'0.0'}
    ]

  it 'should choose token handler correctly', () ->
    h = new TokenizedHeader 'test1;p1=1, test2;q=0.5, *;q=0.1'
    tokenHandlerList = [
      {token: 'test1', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'test1'
    chosen.best.score.should.equal 0.5
    chosen.best.unmatchedParams.should.eql {p1: '1'}

    h = new TokenizedHeader 'test1;p1=1, test2;q=0.5, *;q=0.1'
    tokenHandlerList = [
      {token: 'test1;p1=1', handler: () ->}
    ]
    chosen = h.chooseTokenHandler tokenHandlerList
    chosen.token.should.equal 'test1;p1=1'
    chosen.best.score.should.equal 1
    chosen.best.unmatchedParams.should.eql {}

