define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Get normalized HTTP method
  (method = '') ->
    method.toUpperCase()
