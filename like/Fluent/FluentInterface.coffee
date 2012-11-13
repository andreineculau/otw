# Parts
# Copyright 2011, John Resig
# Dual licensed under the MIT or GPL Version 2 licenses.
# http://jquery.org/license

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"
  merge = (first, second) ->
    secondLen = second.length
    firstLen = first.length
    i = 0
    if _.type(secondLen) is 'number'
      first[firstLen++] = second[i++]  while i < secondLen
    else
      first[firstLen++] = second[i++]  while i in second
    first.length = firstLen
    first


  class FluentInterface
    self = @

    _context: undefined
    _prevInterface: undefined
    length: 0

    ####

    constructor: (context) ->
      return new FluentInterface(context)  unless @ instanceof FluentInterface

      context ?= {}
      @_context = context

    ####

    _sibling: (newInstance) ->
      newInstance ?= new @constructor
      newInstance._context = @_context
      newInstance._prevInterface = @_prevInterface
      newInstance


    sibling: (newInstance) ->
      newInstance = @_sibling newInstance
      merge newInstance, @
      newInstance


    clone: (newInstance) ->
      newInstance = @sibling newInstance
      newInstance._context = _.clone @_context, true
      newInstance

    ####

    context: (key, value) ->
      return @_context  unless key
      @_context[key] = value  if _.type(value) isnt 'undefined'
      @_context[key]


    size: () ->
      @length


    toArray: () ->
      Array::slice.call @


    get: (num) ->
      return @toArray()  unless num?

      num = @length + num  if num < 0
      @[num]

    ####

    pushStack: (stack) ->
      result = @_sibling undefined
      merge result, stack  if stack
      result._prevInterface = @
      result

    end: () ->
      @_prevInterface or @constructor(null)

    #### Mutator methods

    pop: () ->
      result = Array::push.apply @, arguments
      result


    push: () ->
      result = Array::push.apply @, arguments
      result


    reverse: () ->
      result = Array::push.reverse @, arguments
      result


    shift: () ->
      result = Array::shift.apply @, arguments
      result


    splice: () ->
      result = Array::splice.apply @, arguments
      result


    unshift: () ->
      result = Array::unshift.apply @, arguments
      result

    #### Accessor methods

    concat: () ->
      @pushStack Array::concat.apply @, arguments


    join: () ->
      @pushStack Array::join.apply @, arguments


    slice: () ->
      @pushStack Array::slice.apply @, arguments


    eq: (num) ->
      num = @length + num  if num < 0
      result = []
      result.push @[num]  if num >= 0 and num < @length
      @pushStack result


    first: (args...) ->
      args.unshift 0
      @eq.apply @, args


    last: (args...) ->
      args.unshift -1
      @eq.apply @, args

    #### Iterator methods

    each: (iterator, context) ->
      iterator.call context, stackItem  for stackItem in @
      @


    map: (iterator, context) ->
      @pushStack _.map @, iterator, context
