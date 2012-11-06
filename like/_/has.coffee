define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  hasOwnProperty = Object::hasOwnProperty

  (obj, key) ->
    hasOwnProperty.call obj, key
