define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../underscore' # FIXME
  '../_/type'
  '../_/map'
  '../_/prop'
  '../_/has'
  '../_/cloneDeep'
], (
  _
  _type
  _map
  _prop
  _has
  _cloneDeep
) ->
  "use strict"
  {
    compact: _.compact
    type: _type
    map: _map
    prop: _prop
    has: _has
    cloneDeep: _cloneDeep
  }
