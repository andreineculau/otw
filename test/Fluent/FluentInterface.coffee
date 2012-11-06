{should} = require '../utils'

describe 'FluentInterface', () ->
  FluentInterface = require '../../like/Fluent/FluentInterface'
  expectedStack = [1,2,3]
  expectedContext = {test:true}


  describe 'stack', () ->
    it 'should have basic functionality when empty', () ->
      f = new FluentInterface().pushStack expectedStack
      f.length.should.equal f.size()
      f.size().should.equal 3
      f.toArray().should.eql expectedStack
      f.get().should.eql expectedStack
      f.first().get().should.eql [1]
      f.last().get().should.eql [3]

    it 'should have basic functionality when not empty', () ->
      f = new FluentInterface()
      f.length.should.equal f.size()
      f.size().should.equal 0
      f.toArray().should.eql []
      f.get().should.eql []
      f.first().toArray().should.eql []
      f.last().toArray().should.eql []

    it 'should not maintain reference when pushing stack', () ->
      f = new FluentInterface()
      f2 = f.pushStack expectedStack
      f2.get().should.eql expectedStack

      f.length.should.equal f.size()
      f.size().should.equal 0
      f.toArray().should.eql []
      f.get().should.eql []
      f.first().toArray().should.eql []
      f.last().toArray().should.eql []


  describe 'context', () ->
    it 'can be set and read', () ->
      f = new FluentInterface expectedContext
      f.context().should.eql expectedContext
      f.context('test').should.equal true

      f = new FluentInterface()
      f.context 'test', true
      f.context().should.eql expectedContext
      f.context('test').should.equal true


    it 'should maintain reference when pushing stack', () ->
      f = new FluentInterface expectedContext
      f2 = f.pushStack()
      f.context().should.equal f2.context()

    it 'should not maintain reference when creating new instances', () ->
      f = new FluentInterface expectedContext
      f2 = new FluentInterface()
      f.context().should.not.eql f2.context()
