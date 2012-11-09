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
    _parseParamCallback: ([key, value]) ->
      if /^(application|audio|example|image|message|model|multipart|text|video)\/.+$/.test(key) and _.type(value) is 'undefined'
        value = key
        key = 'mediaType'
      [key, value]


    _parseTokenCallback: (token) ->
      syntax = (/\/([a-zA-Z]+)$/.exec(token.mediaType) or [])[1]
      syntax ?= (/\/.+\+([a-zA-Z]+)$/.exec(token.mediaType) or [])[1]
      if syntax
        token.syntax = syntax
      token


    _stringifyParamCallback: ([key, value]) ->
      param = []
      switch key
        when 'mediaType', 'syntax'
          []
        else
          param = [key, value]
      param


    _stringifyTokenCallback: (params, token) ->
      params.unshift token.mediaType
      params


    constructor: (header, config = {}) ->
      return new AcceptHeader(header, config)  unless @ instanceof AcceptHeader
      super
