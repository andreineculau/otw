define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './isNode'
], (
  isNode
) ->
  "use strict"

  if isNode()
    require 'url'
  else
    # FIXME
    throw new Error 'Not Implemented'
