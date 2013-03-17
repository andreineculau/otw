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
    constructor: (header, config = {}) ->
      return new ContentTypeHeader(header, config)  unless @ instanceof ContentTypeHeader
      return header.clone @  if header instanceof ContentTypeHeader
      super
      @tokens = @tokens.slice 0, 1
      @token = @tokens[0]

    _toString: (instance) ->
      @tokens = @tokens.slice 0, 1
      super
