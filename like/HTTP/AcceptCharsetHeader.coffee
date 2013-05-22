define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # AcceptCharsetHeader allows manipulation of Accept-Charset headers
  class AcceptCharsetHeader extends TokenizedHeader
    _key: 'charset'

    constructor: (header, config = {}) ->
      return new AcceptCharsetHeader(header, config)  unless @ instanceof AcceptCharsetHeader
      return header.clone @  if header instanceof AcceptCharsetHeader
      super

