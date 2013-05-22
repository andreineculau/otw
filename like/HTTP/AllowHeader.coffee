define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # AllowHeader allows manipulation of Allow headers
  class AllowHeader extends TokenizedHeader
    _key: 'method'

    constructor: (header, config = {}) ->
      return new AllowHeader(header, config)  unless @ instanceof AllowHeader
      return header.clone @  if header instanceof AllowHeader
      super
