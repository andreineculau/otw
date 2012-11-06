{should} = require '../utils'
TokenizedHeader = require '../../like/HTTP/TokenizedHeader'

describe 'TokenizedHeader', () ->
  it 'should parse headers with one token correctly', () ->
    h = new TokenizedHeader 'test'
    h.tokens.should.eql [{test:true}]

    h = new TokenizedHeader 'test='
    h.tokens.should.eql [{test:''}]

    h = new TokenizedHeader 'test=true'
    h.tokens.should.eql [{test:'true'}]

    h = new TokenizedHeader ' test = true '
    h.tokens.should.eql [{test:'true'}]


  it 'should parse headers with multiple tokens correctly', () ->
    h = new TokenizedHeader 'test,test=,test=true,test="true"'
    h.tokens.should.eql [{test:true},{test:''},{test:'true'},{test:'true'}]


  it 'should parse headers with multiple tokens with parameters correctly', () ->
    h = new TokenizedHeader 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;p1=1;=1'
    h.tokens.should.eql [{test:true,p1:'1'},{test:'',p1:'1',p2:'1'},{test:'true',p1:'1', '':'1'}]


  it 'should be able to stringify correctly', () ->
    h = new TokenizedHeader 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;p1=2;=1;p3=" qwe  qwe  qwe"'
    h.toString().should.equal 'test;p1=1,test=;p1=1;p2=1,test=true;p1=1;=1;p3=" qwe  qwe  qwe"'
