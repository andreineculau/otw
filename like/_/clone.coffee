define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './cloneDeep'
], (
  _extendDeep
)->
  "use strict"

  (obj, deep = false) ->
    _cloneDeep deep, obj
