define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  "use strict"

  # LinkHeader allows manipulation of Link headers
  class LinkHeader extends TokenizedHeader
    _key: 'href'

    constructor: (header, config = {}) ->
      return new LinkHeader(header, config)  unless @ instanceof LinkHeader
      return header.clone @  if header instanceof LinkHeader
      super

    ####

    _parseParamCallback: ([key, value, index]) ->
      if index is 0 and value[0] is '<' and value[value.length-1] is '>' # URIs are wrapped in <>
        value = value.substr 1, value.length-2
      [key, value]


    _stringifyTokenCallback: (params, token) ->
      params[0] = "<#{params[0]}>" # URIs are wrapped in <>
      params
