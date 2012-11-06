define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../_/async'
  '../_/bind'
  '../_/cloneDeep'
  '../_/map'
  '../_/type'
  '../_/Deferred'
], (
  _async
  _bind
  _cloneDeep
  _map
  _type
  Deferred
  _
) ->
  "use strict"
  {
    async: _async
    bind: _bind
    cloneDeep: _cloneDeep
    map: _map
    type: _type
    Deferred: Deferred
  }
