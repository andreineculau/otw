define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  url = require 'url' # FIXME

  # Remove URI hash and/or query
  (URI, options = {}) ->
    options.query ?= false
    options.hash ?= false

    URI = url.parse URI  if _.type(URI) is 'string'
    URI = _.cloneDeep URI
    delete URI.query  unless options.query
    delete URI.search  unless options.query
    delete URI.hash  unless options.query or options.hash
    URI = url.format URI
    URI
