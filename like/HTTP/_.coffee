define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../underscore' # FIXME
  '../_/clone'
  '../_/cloneDeep'
  '../_/configOption'
  '../_/has'
  '../_/map'
  '../_/merge'
  '../_/type'
], (
  _
  clone
  cloneDeep
  configOption
  has
  map
  merge
  type
) ->
  "use strict"
  {
    clone
    cloneDeep
    compact: _.compact # FIXME
    configOption
    has
    map
    merge
    type
  }
