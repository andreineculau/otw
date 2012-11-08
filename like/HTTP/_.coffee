define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../underscore' # FIXME
  '../_/clone'
  '../_/cloneDeep'
  '../_/configOption'
  '../_/has'
  '../_/map'
  '../_/merge'
  '../_/type'
], (
  _
  _clone
  _cloneDeep
  _configOption
  _has
  _map
  _merge
  _type
) ->
  "use strict"
  {
    clone: _clone
    cloneDeep: _cloneDeep
    compact: _.compact
    configOption: _configOption
    has: _has
    map: _map
    merge: _merge
    type: _type
  }
