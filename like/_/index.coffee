define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './async'
  './bind'
  './clone'
  './cloneDeep'
  './each'
  './extendDeep'
  './has'
  './map'
  './merge'
  './prop'
  './type'
  './Deferred'
], (
  _async
  _bind
  _clone
  _cloneDeep
  _each
  _extendDeep
  _has
  _map
  _merge
  _prop
  _type
  Deferred
) ->
  "use strict"

  {
    async: _async
    bind: _bind
    clone: _clone
    cloneDeep: _cloneDeep
    each: _each
    extendDeep: _extendDeep
    has: _has
    map: _map
    merge: _merge
    prop: _prop
    type: _type
    Deferred: Deferred
  }
