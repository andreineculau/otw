define = require('amdefine')(module)  if typeof define isnt 'function'

define [
  './_'
  './AcceptHeader'
], (
  _
  AcceptHeader
) ->
  # Content-Type allows manipulation of Content-Type headers
  class ContentTypeHeader extends AcceptHeader
    _token: {}
    _.prop.call @, 'token'

    _tokens: [@_token]


    constructor: (header, options = {}) ->
      unless (@ instanceof ContentTypeHeader)
        return new ContentTypeHeader(header, options)
      super header, options
      @_tokens = @_tokens.slice 0, 1
      @_token = @_tokens[0]

    _toString: (instance) ->
      @_tokens = @_tokens.slice 0, 1
      super instance
