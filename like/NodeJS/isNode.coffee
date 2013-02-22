define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"

  () ->
    process?.versions?.node and
      module?.exports
