define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # TokenizedHeader allows manipulation of "key1; key2=value, key3=value" headers
  class TokenizedHeader
    self = @
    _key: undefined
    _metaKeys: undefined
    config: undefined
    tokens: undefined

    constructor: (header = '', config = {}) ->
      return new TokenizedHeader(header, config)  unless @ instanceof TokenizedHeader
      return header.clone @  if header instanceof TokenizedHeader

      # Shortcuts
      _.configOption.call @, configOption  for configOption in [
        'tokenSep'
        'paramSep'
        'keyValueSep'
      ]

      defaultConfig =
        tokenSep: ','
        paramSep: ';'
        keyValueSep: '='
        hasKey: false
      @config = _.merge defaultConfig, config
      @_metaKeys or= []
      @_parseHeader header


    clone: (newInstance) ->
      for param in [
        '_key'
        '_metaKeys'
        'config'
        'tokens'
      ]
        newInstance[param] = _.clone @[param], true

    ####

    _parseHeader: (header) ->
      tokens = header.split @tokenSep
      tokens = _.map tokens, (token) =>
        token = token.trim()
        params = token.split @paramSep
        token = {}
        for param, index in params
          param = param.trim()
          [key, value] = param.split @keyValueSep
          key = key.toLowerCase().trim()
          if @_key and index is 0 and _.type(value) is 'undefined'
            value = key
            key = @_key
          [key, value] = @_parseParamCallback [key, value, index]  if @_parseParamCallback
          if _.type(value) is 'string'
            value = value.toLowerCase().trim()
            value = value.substr 1, value.length-2  if /^\".*\"$/.test value
          else
            value = true
          token[key] ?= value
        token = @_parseTokenCallback token  if @_parseTokenCallback
        token
      @tokens = tokens


    _tokenToString: (token) ->
      params = _.map token, (value, key) =>
        return  if key in @_metaKeys or key is @_key
        [key, value] = @_stringifyParamCallback [key, value]  if @_stringifyParamCallback
        return  if _.type(key) is 'undefined'
        return key  if value is true
        value = "\"#{value}\""  if /\ /.test value
        [key, value].join @keyValueSep
      params = _.compact params
      params.unshift token[@_key]  if @_key
      params = @_stringifyTokenCallback params, token  if @_stringifyTokenCallback
      params.join @paramSep


    _toString: (tokens) ->
      tokens = _.map tokens, @_tokenToString, @
      tokens = _.compact tokens
      tokens.join @tokenSep


    _getSortedTokens: (tokens) ->
      # Sort by specificity first
      tokens = _.sortBy tokens, (token) ->
        100 - _.size token
      # Sort by quality
      tokens = _.sortBy tokens, (token) ->
        q = token.q or '1'
        1 - parseFloat q
      tokens


    _filter: (tokens, iterator) ->
      tokens = _.filter tokens, iterator  if iterator
      @_tokensSortedByQuality(tokens)[0]


    _normalizeTokenHandlers: (tokenHandlerList) ->
      # FIXME make class
      if _.type(tokenHandlerList) is 'object'
        tokenHandlerList = _.map tokenHandlerList, (handler, token) ->
          {
            token
            handler
          }
      list = []
      for tokenHandler in tokenHandlerList
        bestScore = 0
        normalizedToken = tokenHandler.token
        normalizedToken = new @constructor(normalizedToken, @config)  if _.type(normalizedToken) is 'string'
        normalizedToken = normalizedToken.tokens[0]  if normalizedToken instanceof @constructor
        normalizedTokenSize = _.size normalizedToken
        list.push _.extend {}, tokenHandler, {
          normalizedToken
          normalizedTokenSize
        }
      # Sort by specificity first
      list = _.sortBy list, (tokenHandler) ->
        100 - _.size tokenHandler.normalizedToken
      # Sort by quality
      list = _.sortBy list, (tokenHandler) ->
        q = tokenHandler.normalizedToken.q or '1'
        1 - parseFloat q
      list


    _matchParam: (key, knownValue, value) ->
      result = knownValue is value or '*' in [knownValue, value]
      result


    _getMatchWeight: (key, knownValue, value) ->
      weight = outOf = 1
      weight = outOf = 10  if @_key and key is @_key
      weight = weight / 2  if '*' in [knownValue, value]
      [weight, outOf]

    ####

    toString: () ->
      @_toString @tokens


    keys: () ->
      result = []
      return result  unless @_key
      for token in @tokens
        result.push token[@_key]
      result


    getSortedTokens: () ->
      @_getSortedTokens @tokens


    filter: (iterator) ->
      @_chooseToken @tokens, iterator


    scoreTokenHandlers: (tokenHandlerList) ->
      tokens = @getSortedTokens()
      tokenHandlerList = @_normalizeTokenHandlers tokenHandlerList
      list = []
      for tokenHandler in tokenHandlerList
        best = {
          acceptedToken: undefined
          score: 0
          unmatchedParams: {}
        }
        for acceptedToken in tokens
          score = [0, 0]
          unmatchedParams = {}
          keys = _.union _.keys(tokenHandler.normalizedToken), _.keys(acceptedToken)
          for key in keys
            continue  if key is 'q'
            knownValue = tokenHandler.normalizedToken[key]
            [weight, outOf] = @_getMatchWeight key, knownValue, acceptedToken[key]
            isMatch = @_matchParam key, knownValue, acceptedToken[key]
            score[0] += weight  if isMatch
            score[1] += outOf
            unmatchedParams[key] = acceptedToken[key]  unless isMatch
          score = Math.round(score[0] / score[1] * 100) / 100
          best = {
            acceptedToken
            score
            unmatchedParams
          }  if score > best.score
          break  if score is 1
        list.push _.extend {}, tokenHandler, {
          best
        }
      list


    chooseTokenHandler: (tokenHandlerList) ->
      tokenHandlerList = @scoreTokenHandlers tokenHandlerList
      chosen = _.find tokenHandlerList, (tokenHandler) ->
        tokenHandler.best.score
      chosen or= tokenHandlerList[0]
      chosen


    matchesToken: (token) ->
      tokenHandlerList = {}
      tokenHandlerList[token] = () ->
      chosen = @chooseTokenHandler tokenHandlerList
      chosen isnt undefined
