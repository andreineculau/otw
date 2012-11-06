define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './like/type'

  # Collection
  './like/each'
  './like/map'

  # Function
  './like/bind'
  './like/async'
], (
  _type
  _each
  _map
  _bind
  _async
) ->
  "use strict"
  return {
    type: _type

    # Collection
    each: _each
    map: _map

    # Function
    bind: _bind
    async: _async
  }
