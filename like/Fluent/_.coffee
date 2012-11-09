define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../_/async'
  '../_/bind'
  '../_/clone'
  '../_/eachAsync'
  '../_/map'
  '../_/mapAsync'
  '../_/merge'
  '../_/type'
  '../_/Deferred'
], (
  _async
  _bind
  _clone
  _eachAsync
  _map
  _mapAsync
  _merge
  _type
  Deferred
  _
) ->
  "use strict"
  {
    async: _async
    bind: _bind
    clone: _clone
    eachAsync: _eachAsync
    map: _map
    mapAsync: _mapAsync
    merge: _merge
    type: _type
    Deferred: Deferred
  }
