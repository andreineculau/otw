define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
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

    i = -1

    next = (err, resp) ->
      return callback err  if err
      result[key] = resp  if i isnt -1
      i++
      key = keys[i] ? i
      return callback err, result  if i is l
      iterator.call (context ? obj), next, obj[key], key, obj
    next()
