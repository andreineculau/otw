define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  nativeForEach = Array::forEach

  (obj, iterator, context) ->
    return  unless obj?
    return obj.forEach iterator, context  if nativeForEach and obj.forEach is nativeForEach
    keys = []
    if obj.length is +obj.length
      l = obj.length
    else
      keys.push key  for own key of obj
      l = keys.length

    i = 0

    while i < l
      key = keys[i] ? i
      iterator.call context, obj[key], key, obj
      i++
