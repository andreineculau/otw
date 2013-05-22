define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # AcceptLanguageHeader allows manipulation of Accept-Language headers
  class AcceptLanguageHeader extends TokenizedHeader
    _key: 'lang'

    constructor: (header, config = {}) ->
      return new AcceptLanguageHeader(header, config)  unless @ instanceof AcceptLanguageHeader
      return header.clone @  if header instanceof AcceptLanguageHeader
      super
