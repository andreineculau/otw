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
    config: undefined
    # Shortcuts
    _.configOption.call @, configOption  for configOption in [
      'tokenSep'
      'paramSep'
      'keyValueSep'
    ]
    tokens: undefined

    constructor: (header, config = {}) ->
      return new TokenizedHeader(header, config)  unless @ instanceof TokenizedHeader
      return header.clone @  if header instanceof TokenizedHeader

      defaultConfig =
        tokenSep: ','
        paramSep: ';'
        keyValueSep: '='
      @config = _.merge defaultConfig, config
      @_parseHeader header


    clone: (newInstance) ->
      newInstance.config = _.clone @config, true
      newInstance.tokens = _.clone @tokens, true

    ####

    _parseHeader: (header) ->
      tokens = header.split @tokenSep
      tokens = _.map tokens, (token) =>
        token = token.trim()
        params = token.split @paramSep
        token = {}
        for param in params
          param = param.trim()
          [key, value] = param.split @keyValueSep
          [key, value] = @_parseParamCallback [key, value]  if @_parseParamCallback
          key = key.trim()
          if _.type(value) is 'string'
            value = value.trim()
            value = value.substr 1, value.length-2  if /^\".*\"$/.test value
          else
            value = true
          token[key] ?= value
        token = @_parseTokenCallback token  if @_parseTokenCallback
        token
      @tokens = tokens

    ####

    _toString: (tokens) ->
      tokens = _.map tokens, (token) =>
        params = _.map token, (value, key) =>
          [key, value] = @_stringifyParamCallback [key, value]  if @_stringifyParamCallback
          return  if _.type(key) is 'undefined'
          return key  if value is true
          value = "\"#{value}\""  if /\ /.test value
          [key, value].join @keyValueSep
        params = _.compact params
        params = @_stringifyTokenCallback params, token  if @_stringifyTokenCallback
        params.join @paramSep
      tokens = _.compact tokens
      tokens.join @tokenSep


    toString: () ->
      @_toString @tokens
