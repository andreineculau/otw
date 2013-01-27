define = require('amdefine')(module)  if typeof define isnt 'function'
define [
], (
) ->
  "use strict"

  # Get normalized headers
  (headers = {}) ->
    result = {}
    result[header.toLowerCase()] = value  for header, value of headers
    result
