define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  # TokenizedHeader allows manipulation of "key1; key2=value, key3=value" headers
  class TokenizedHeader
    _tokens: []
    _.prop.call @, 'tokens'

    # options
    _tokenSep: ','
    _paramSep: ';'
    _keyValueSep: '='
    _parseParamCallback: undefined
    _stringifyParamCallback: undefined
    _optionNames = [
      'tokenSep'
      'paramSep'
      'keyValueSep'
      'parseParamCallback'
      'stringifyParamCallback'
    ]
    _optionNames: _optionNames
    for _optionName in _optionNames
      _.prop.call @, _optionName


    constructor: (header, options = {}) ->
      unless (@ instanceof TokenizedHeader)
        return new TokenizedHeader(header, config)

      if header instanceof TokenizedHeader
        for optionName in @_optionNames
          @["_#{optionName}"] = _.cloneDeep true, header[optionName]
      else
        @_parseHeader header

      for own optionName, option of options
        continue  unless optionName in @_optionNames
        @["_#{optionName}"] = option


    _parseHeader: (header) ->
      tokens = header.split @_tokenSep
      tokens = _.map tokens, (token) =>
        token = token.trim()
        params = token.split @_paramSep
        token = {}
        for param in params
          param = param.trim()
          [key, value] = param.split @_keyValueSep
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
      @_tokens = tokens


    _toString: (tokens) ->
      tokens = _.map tokens, (token) =>
        params = _.map token, (value, key) =>
          [key, value] = @_stringifyParamCallback [key, value]  if @_stringifyParamCallback
          return  if _.type(key) is 'undefined'
          return key  if value is true
          value = "\"#{value}\""  if /\ /.test value
          [key, value].join @_keyValueSep
        params = _.compact params
        params = @_stringifyTokenCallback params, token  if @_stringifyTokenCallback
        params.join @_paramSep
      tokens = _.compact tokens
      tokens.join @_tokenSep


    toString: () ->
      @_toString @._tokens
