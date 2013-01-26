define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './like/_'
  './like/Fluent'
  './like/HTTP'
  './like/JSON'
], (
  _
  Fluent
  HTTP
  JSON
) ->
  "use strict"
  _.Fluent = Fluent
  _.HTTP = HTTP
  _.JSON = JSON
  _
