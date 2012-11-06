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
  core_slice = Array.prototype.slice
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
    _defaultContext: {}
    _prevInterface: undefined
    length: 0

    ####

    constructor: (context) ->
      context ?= {}
      @_context = _.cloneDeep true, @_defaultContext, context

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
      newInstance._context = _.cloneDeep @_context
      newInstance

    ####

    context: (key, value) ->
      return @_context  unless key
      @_context[key] = value  if _.type(value) isnt 'undefined'
      @_context[key]


    size: () ->
      @length


    toArray: () ->
      core_slice.call @


    get: (numOrKey) ->
      return @toArray()  unless num?

      if _.type(numOrKey) is 'string'
        return @[0][numOrKey]

      num = @length + num  if num < 0
      @[num]

    ####

    pushStack: (stack) ->
      result = @_sibling undefined
      merge result, stack  if stack
      result._prevInterface = @
      result


    slice: () ->
      @pushStack slice.apply(@, arguments), 'slice', core_slice.call(arguments).join(',')


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


    each: (iterator, context) ->
      iterator.call context, stackItem  for stackItem in @
      @


    map: (iterator, context) ->
      @pushStack _.map @, iterator, context


    end: () ->
      @_prevInterface or @constructor(null)
