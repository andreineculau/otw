define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './each'
], (
  _each
) ->
  "use strict"

  (obj, callback, iterator, context) ->
    callback()  unless obj?
    keys = []
    if obj.length is +obj.length
      l = obj.length
      result = []
    else
      keys.push key  for own key of obj
      l = keys.length
      result = {}

    i = 0

    next = (err, resp) ->
      return callback err  if err
      result[key] = resp  if i isnt 0
      i++
      key = keys[i] ? i
      return callback err, result  if i is l
      iterator.call context, next, obj[key], key, obj
    next()
