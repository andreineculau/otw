define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  'node.extend'
], (
  _extendDeep
)->
  "use strict"

  (args...) ->
    args.push true
    _extendDeep.apply @, args
