# Parts
# Underscore.js 1.4.2
# http://underscorejs.org
# (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  nativeForEach = Array::forEach
  breaker = {}

  (obj, iterator, context) ->
    return  unless obj?
    if nativeForEach and obj.forEach is nativeForEach
      obj.forEach iterator, context
    else if obj.length is +obj.length
      i = 0
      l = obj.length

      while i < l
        return  if iterator.call(context, obj[i], i, obj) is breaker
        i++
    else
      for key of obj
        return  if _.has(obj, key) and iterator.call(context, obj[key], key, obj) is breaker
