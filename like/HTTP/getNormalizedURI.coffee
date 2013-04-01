define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  '../NodeJS/url'
], (
  _
  Url
) ->
  "use strict"

  # Remove URI hash and/or query
  (URI, options = {}) ->
    options.query ?= false
    options.hash ?= false

    URI = Url.parse URI  if _.type(URI) is 'string'
    URI = _.cloneDeep URI
    delete URI.query  unless options.query
    delete URI.search  unless options.query
    delete URI.hash  unless options.query or options.hash
    URI = Url.format URI
    URI
