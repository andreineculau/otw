define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  'lodash'
  './_'
], (
  _
  __
) ->
  "use strict"

  delete __.clone
  delete __.merge
  _.mixin __
  _
