define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  (str, pattern) ->
    pattern = pattern or /[\u007f-\uffff]/g
    str = str.replace pattern, (char) ->
      '\\u' + ('0000' + char.charCodeAt(0).toString(16)).slice(-4)
    str
