define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './buffer'
  './crypto'
  './isNode'
  './url'
], (
  buffer
  crypto
  isNode
  url
) ->
  "use strict"

  {
    buffer
    crypto
    isNode
    url
  }
