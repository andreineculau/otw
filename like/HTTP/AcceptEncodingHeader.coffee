define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # AcceptEncoding allows manipulation of Accept-Encoding headers
  class AcceptEncodingHeader extends TokenizedHeader
    _key: 'encoding'
