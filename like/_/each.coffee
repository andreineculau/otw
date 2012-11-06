# Parts
# Underscore.js 1.4.2
# http://underscorejs.org
# (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './has'
], (
  _has
) ->
  "use strict"
  nativeForEach = Array::forEach

  (obj, iterator, context) ->
    return  unless obj?
    if nativeForEach and obj.forEach is nativeForEach
      obj.forEach iterator, context
    else if obj.length is +obj.length
      i = 0
      l = obj.length

      while i < l
        iterator.call context, obj[i], i, obj
        i++
    else
      for own key of obj
        iterator.call context, obj[key], key, obj
