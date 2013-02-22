define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './crypto'
  './url'
], (
  crypto
  url
) ->
  "use strict"
  {
    crypto
    url
  }
