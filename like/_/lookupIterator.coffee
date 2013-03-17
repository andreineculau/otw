define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './type'
], (
  _type
) ->
  "use strict"

  (value) ->
    return value  if _type(value) is 'function'
    (obj) -> obj[value]
