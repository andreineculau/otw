define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  '../NodeJS/url'
], (
  _
  url
) ->
  "use strict"

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
