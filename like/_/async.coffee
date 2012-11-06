define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  doNext = process?.nextTick or setTimeout

  (fun, context) ->
  (fun, context) ->
    (args...) -> doNext () -> fun.apply (context or @), args
