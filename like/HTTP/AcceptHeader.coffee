define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # Accept allows manipulation of Accept headers
  class AcceptHeader extends TokenizedHeader
    _key: 'mediaType'
    _metaKeys: ['type', 'subtype', 'syntax']

    constructor: (header, config = {}) ->
      return new AcceptHeader(header, config)  unless @ instanceof AcceptHeader
      return header.clone @  if header instanceof AcceptHeader
      super

    ####

    _parseTokenCallback: (token) ->
      [type, subtype] = (/^(.*)\/(.*)$/.exec(token.mediaType) or []).slice 1
      syntax = (/\/(?:.+\+)?([a-zA-Z\*]+)$/.exec(token.mediaType) or [])[1]
      token.type = type  if type
      token.subtype = subtype  if subtype
      token.syntax = syntax  if syntax
      token


    _matchParam: (key, knownValue, value) ->
      result = super
      if key is @_key
        [knownType, knownSubtype] = (/^(.*)\/(.*)$/.exec(knownValue) or []).slice 1
        [type, subtype] = (/^(.*)\/(.*)$/.exec(value) or []).slice 1
        result = result or (knownType is type and '*' in [knownSubtype, subtype])
        result = result or (knownSubtype is subtype and '*' in [knownType, type])
        result = result or ('*' in [knownSubtype, subtype] or '*' in [knownType, type])
      result


    _getMatchWeight: (key, knownValue, value) ->
      [weight, outOf] = super
      if key is @_key
        [knownType, knownSubtype] = (/^(.*)\/(.*)$/.exec(knownValue) or []).slice 1
        [type, subtype] = (/^(.*)\/(.*)$/.exec(value) or []).slice 1
        weight = weight / 2  if (knownType is type and '*' in [knownSubtype, subtype])
        weight = weight / 2  if (knownSubtype is subtype and '*' in [knownType, type])
        weight = weight / 4  if ('*' in [knownSubtype, subtype] or '*' in [knownType, type])
      [weight, outOf]
