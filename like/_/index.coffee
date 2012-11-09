define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './async'
  './bind'
  './clone'
  './cloneDeep'
  './configOption'
  './each'
  './eachAsync'
  './extendDeep'
  './has'
  './map'
  './mapAsync'
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
  _eachAsync
  _extendDeep
  _has
  _map
  _mapAsync
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
    eachAsync: _eachAsync
    extendDeep: _extendDeep
    has: _has
    map: _map
    mapAsync: _mapAsync
    merge: _merge
    type: _type
    Deferred: Deferred
  }
