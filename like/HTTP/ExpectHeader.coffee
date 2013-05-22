define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # ExpectHeader allows manipulation of Expect headers
  class ExpectHeader extends TokenizedHeader
    _key: 'expectation'

    constructor: (header, config = {}) ->
      return new ExpectHeader(header, config)  unless @ instanceof ExpectHeader
      return header.clone @  if header instanceof ExpectHeader
      super

    ####

    _parseTokenCallback: (token) ->
      [key, value] = token.expectation.split '='
      token.key = key  if key
      token.value = value  if value
      token
