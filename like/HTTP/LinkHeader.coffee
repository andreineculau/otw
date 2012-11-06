define = require('amdefine')(module)  if typeof define isnt 'function'

define [
  './_'
  './TokenizedHeader'
], (
  _
  TokenizedHeader
) ->
  # LinkHeader allows manipulation of Link headers
  class LinkHeader extends TokenizedHeader
    _parseParamCallback: ([key, value]) ->
      if /^<.*>$/.test(key) and _.type(value) is 'undefined'
        value = key.substr 1, key.length-2
        key = 'href'
      [key, value]


    _stringifyParamCallback: ([key, value]) ->
      param = []
      switch key
        when 'href'
          []
        else
          param = [key, value]
      param


    _stringifyTokenCallback: (params, token) ->
      params.unshift "<#{token.href}>"
      params


    constructor: (header, config = {}) ->
      unless (@ instanceof LinkHeader)
        return new LinkHeader(header, config)
      super header, config
