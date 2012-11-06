define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  (obj) ->
    return String(obj)  unless obj?
    Object::toString.call(obj).slice(8, -1).toLowerCase() or 'object'
