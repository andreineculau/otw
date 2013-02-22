define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './like/_'
  './like/Fluent'
  './like/HTTP'
  './like/JSON'
  './like/NodeJS'
], (
  _
  Fluent
  HTTP
  JSON
  NodeJS
) ->
  "use strict"
  _.Fluent = Fluent
  _.HTTP = HTTP
  _.JSON = JSON
  _.NodeJS = NodeJS
  _
