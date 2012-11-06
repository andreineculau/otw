define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  (str, pattern, callback) ->
    pattern ?= /\\u([0-9a-fA-F]{4})/g
    callback ?= (match, digits) ->
      String.fromCharCode parseInt(digits, 16)
    str = str.replace pattern, callback
    str
