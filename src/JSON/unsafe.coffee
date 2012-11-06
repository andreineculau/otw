define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  (str, pattern) ->
    pattern = pattern or /\\u([0-9a-fA-F]{4})/g
    str = str.replace pattern, (match, digits) ->
      String.fromCharCode parseInt(digits, 16)
    str
