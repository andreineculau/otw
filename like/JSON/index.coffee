define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './safe'
  './unsafe'
], (
  safe
  unsafe
) ->
  "use strict"
  {
    safe
    unsafe
  }
