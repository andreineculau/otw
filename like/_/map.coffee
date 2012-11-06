# Parts
# Underscore.js 1.4.2
# http://underscorejs.org
# (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './each'
], (
  _each
) ->
  "use strict"
  nativeMap = Array::map

  (obj, iterator, context) ->
    results = []
    return results  unless obj?
    return obj.map(iterator, context)  if nativeMap and obj.map is nativeMap
    _each obj, (value, index, list) ->
      results[results.length] = iterator.call(context, value, index, list)
    results
