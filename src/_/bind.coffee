# Parts
# Underscore.js 1.4.2
# http://underscorejs.org
# (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './type'
], (
  _type
) ->
  "use strict"
  nativeBind = Function::bind
  slice = Array::slice

  (func, context) ->
    return nativeBind.apply(func, slice.call(arguments_, 1))  if func.bind is nativeBind and nativeBind
    throw new TypeError  unless _type(func) is 'function'
    args = slice.call(arguments_, 2)
    bound = ->
      return func.apply(context, args.concat(slice.call(arguments_)))  unless this instanceof bound
      ctor:: = func::
      self = new ctor
      result = func.apply(self, args.concat(slice.call(arguments_)))
      return result  if Object(result) is result
      self
