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
  async
  bind
  clone
  eachAsync
  map
  mapAsync
  merge
  type
  Deferred
  _
) ->
  "use strict"
  {
    async
    bind
    clone
    eachAsync
    map
    mapAsync
    merge
    type
    Deferred
  }
