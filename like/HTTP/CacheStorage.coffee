define = require('amdefine')(module)  if typeof define isnt 'function'
define [
], (
) ->
  "use strict"

  # Cache Storage (abstract)
  class CacheStorage
    self = @

    constructor: () ->
    store: (req, res) ->
    update: (item) ->
    getForURI: (URI) -> []
    eraseForURI: (URI) ->
    erase: () ->
