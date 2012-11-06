define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './has'
], (
  _has
) ->
  "use strict"

  (obj, callback, iterator, context) ->
    callback()  unless obj?
    keys = []
    if obj.length is +obj.length
      l = obj.length
    else
      keys.push key  for own key of obj
      l = keys.length

    i = 0

    next = (err) ->
      return callback err  if err
      i++
      key = keys[i] ? i
      return callback err  if i is l
      iterator.call context, next, obj[key], key, obj
    next()
