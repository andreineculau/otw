define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './AcceptHeader'
], (
  _
  AcceptHeader
) ->
  "use strict"

  # Content-Type allows manipulation of Content-Type headers
  class ContentTypeHeader extends AcceptHeader
    self = @

    ####

    constructor: (header, options = {}) ->
      unless (@ instanceof ContentTypeHeader)
        return new ContentTypeHeader(header, options)
      super
      @tokens = @tokens.slice 0, 1
      @token = @tokens[0]

    _toString: (instance) ->
      @tokens = @tokens.slice 0, 1
      super
