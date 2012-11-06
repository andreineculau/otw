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

  (fun, args...) ->
    return nativeBind.apply fun, args  if fun.bind is nativeBind and nativeBind
    throw new TypeError  unless _type(func) is 'function'
    context = args.shift()
    bound = ->
      return fun.apply context, args  unless this instanceof bound
      ctor:: = fun::
      self = new ctor
      result = fun.apply self, args
      return result  if Object(result) is result
      self
