define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  'lodash'
  './_'
], (
  _
  __
) ->
  "use strict"

  commonFuns = _.intersection(_.keys(__), _.keys(_))
  __ = _.omit __, commonFuns
  _.mixin __
  _
