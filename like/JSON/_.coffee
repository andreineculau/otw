define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../_/clone'
  '../_/cloneDeep'
  '../_/type'
], (
  clone
  cloneDeep
  type
) ->
  "use strict"
  {
    clone
    cloneDeep
    type
  }
