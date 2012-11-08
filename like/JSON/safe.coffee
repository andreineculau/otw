define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"

  (str, pattern, callback) ->
    pattern ?= /[\u007f-\uffff]/g
    callback ?= (char) ->
      '\\u' + ('0000' + char.charCodeAt(0).toString(16)).slice(-4)
    str = str.replace pattern, callback
    str
