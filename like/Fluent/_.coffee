define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../_/async'
  '../_/bind'
  '../_/cloneDeep'
  '../_/eachAsync'
  '../_/map'
  '../_/mapAsync'
  '../_/type'
  '../_/Deferred'
], (
  _async
  _bind
  _cloneDeep
  _eachAsync
  _map
  _mapAsync
  _type
  Deferred
  _
) ->
  "use strict"
  {
    async: _async
    bind: _bind
    cloneDeep: _cloneDeep
    eachAsync: _eachAsync
    map: _map
    mapAsync: _mapAsync
    type: _type
    Deferred: Deferred
  }
