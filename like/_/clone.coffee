define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './cloneDeep'
], (
  _cloneDeep
)->
  "use strict"

  (obj, deep = false) ->
    _cloneDeep deep, obj
