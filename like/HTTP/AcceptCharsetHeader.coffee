define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # AcceptCharset allows manipulation of Accept-Charset headers
  class AcceptCharsetHeader extends TokenizedHeader
    _key: 'charset'
