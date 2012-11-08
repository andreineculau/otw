define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './async'
  './bind'
  './clone'
  './cloneDeep'
  './configOption'
  './each'
  './extendDeep'
  './has'
  './map'
  './merge'
  './type'
  './Deferred'
], (
  _async
  _bind
  _clone
  _cloneDeep
  _configOption
  _each
  _extendDeep
  _has
  _map
  _merge
  _type
  Deferred
) ->
  "use strict"

  {
    async: _async
    bind: _bind
    clone: _clone
    cloneDeep: _cloneDeep
    configOption: _configOption
    each: _each
    extendDeep: _extendDeep
    has: _has
    map: _map
    merge: _merge
    type: _type
    Deferred: Deferred
  }
