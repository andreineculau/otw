define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './extendDeep'
], (
  _extendDeep
)->
  "use strict"

  (args...) ->
    args.unshift true
    _extendDeep.apply {}, args
