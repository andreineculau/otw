{should} = require '../utils'

describe 'type', () ->
  type = require '../../like/_/type'

  ####

  it 'should return expected types', ->
    type(4).should.equal 'number'
    type('abc').should.equal 'string'
    type(true).should.equal 'boolean'
    type(a: 4).should.equal 'object'
    type([1, 2, 3]).should.equal 'array'
    type(new Date()).should.equal 'date'
    type(/a-z/).should.equal 'regexp'
    type(Math).should.equal 'math'
    type(JSON).should.equal 'json'
    type(new Number(4)).should.equal 'number'
    type(new String('abc')).should.equal 'string'
    type(new Boolean(true)).should.equal 'boolean'
    type(new ReferenceError).should.equal 'error'
    (->
      type arguments
    )().should.equal 'arguments'
