define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../underscore' # FIXME
  '../_/clone'
  '../_/cloneDeep'
  '../_/configOption'
  '../_/extend'
  '../_/has'
  '../_/keys'
  '../_/map'
  '../_/merge'
  '../_/sortBy'
  '../_/size'
  '../_/type'
], (
  _
  clone
  cloneDeep
  configOption
  extend
  has
  keys
  map
  merge
  sortBy
  size
  type
) ->
  "use strict"
  {
    clone
    cloneDeep
    compact: _.compact # FIXME
    configOption
    extend
    find: _.find # FIXME
    has
    keys
    map
    merge
    sortBy
    size
    type
    union: _.union # FIXME
  }
