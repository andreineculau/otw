define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './like/_'
  './like/HTTP'
  './like/JSON'
], (
  _
  HTTP
  JSON
) ->
  "use strict"
  _.HTTP = HTTP
  _.JSON = JSON