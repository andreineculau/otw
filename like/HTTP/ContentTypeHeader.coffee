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
      return new ContentTypeHeader(header, config)  unless @ instanceof ContentTypeHeader
      super
      @tokens = @tokens.slice 0, 1
      @token = @tokens[0]

    _toString: (instance) ->
      @tokens = @tokens.slice 0, 1
      super
