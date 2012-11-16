define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './type'
], (
  _type
) ->
  "use strict"

  (obj) ->
    return _type(obj) is 'object' && obj.__proto__ == Object::
