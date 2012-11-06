define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AsyncFluentInterface'
  './FluentInterface'
], (
  AsyncFluentInterface
  FluentInterface
) ->
  "use strict"
  {
    AsyncFluentInterface: AsyncFluentInterface
    FluentInterface: FluentInterface
  }
