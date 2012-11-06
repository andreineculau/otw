define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './async'
  './bind'
  './cloneDeep'
  './each'
  './extendDeep'
  './has'
  './map'
  './prop'
  './type'
], (
  _async
  _bind
  _cloneDeep
  _each
  _extendDeep
  _has
  _map
  _prop
  _type
) ->
  "use strict"
  {
    async: _async
    bind: _bind
    cloneDeep: _cloneDeep
    each: _each
    extendDeep: _extendDeep
    has: _has
    map: _map
    prop: _prop
    type: _type
  }
