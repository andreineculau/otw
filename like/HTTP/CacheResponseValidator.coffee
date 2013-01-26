define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './TokenizedHeader'
  './CachedRequestValidator'
], (
  _
  TokenizedHeader
  CachedRequestValidator
) ->
  "use strict"

  Crypto = require 'crypto' # FIXME

  # Validate if a HTTP response can be cached
  class CacheResponseValidator
    self = @
    _cachedRequestValidator: undefined
    _validators: undefined
    _flag: undefined
    config: undefined

    constructor: (config = {}) ->
      # Shortcuts
      _.configOption.call @, configOption  for configOption in [
        'userAgent'
      ]

      defaultConfig =
        userAgent: false
      @config = _.merge defaultConfig, config

      @_cachedRequestValidator = new CachedRequestValidator
      @_validators = [
        @_isntPrivate
        @_isntNoStore
        @_isntMaxAgeZero
        @_isMaxAgeFuture
        @_hasExpires
        @_hasLastModified
        @_hasCacheableStatusCode
      ]

    store: (flag) ->
      return  unless _.type(@_flag.store) is 'undefined'
      @_flag.store = !!flag

    expires: (timestamp) ->
      @_flag.until = timestamp  if timestamp < @_flag.until

    # RFC 2616 Section 14.9
    _isntPrivate: (res, resHeaders) ->
      @store false  if !@config.userAgent and /private/.test(resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isntNoStore: (res, resHeaders) ->
      @store false  if /no-store(?!=)/.test(resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isntMaxAgeZero: (res, resHeaders) ->
      @store false  if /max-age=(0|-[0-9]+)/.test(resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isMaxAgeFuture: (res, resHeaders) ->
      matches = /max-age=([0-9]+)/.exec(resHeaders['cache-control'] or '')
      return  unless matches
      @store true
      @expires new Date().getTime() + matches[1]

    _hasExpires: (res, resHeaders) ->
      return  unless resHeaders['expires']
      @store true
      @expires new Date(resHeaders['expires'])

    # RFC 2616 Section 13.3.1
    _hasLastModified: (res, resHeaders) ->
      @store true  if resHeaders['last-modified']

    _cacheableStatusCodes:
      200: 'OK'
      203: 'Non-Authoritative Information'
      300: 'Multiple Choices'
      301: 'Moved Permanently'
      401: 'Unauthorized'

    _hasCacheableStatusCode: (res, resHeaders) ->
      @store true  if res.statusCode of @._cacheableStatusCodes

    _addStoreID: (req, res, resHeaders) ->
      reqHeaders = {}
      if req.headers
        for header, value of req.headers
          reqHeaders[header.toLowerCase()] = value
      hash = [
        req.url.toString()
      ]
      if resHeaders['vary']
        vary = new TokenizedHeader resHeaders['vary']
        for token of vary.tokens[0]
          token = token.toLowerCase()
          hash.push [token, reqHeaders[token]].join '='
          @_flag.varyHeaders[token] = reqHeaders[token]
      hash = hash.join '\n'
      hash = Crypto.createHmac('SHA256', req.url.toString()).update(hash).digest('base64')
      @_flag.ID = hash

    test: (req, res) ->
      @_flag =
        store: undefined
        ID: undefined
        varyHeaders: {}
        until: new Date().getTime() + 60 * 60 * 24 * 365.25 # RFC - caching should not exceed one year from now
      if @_cachedRequestValidator.test(req).retrieve
        resHeaders = {}
        if res.headers
          for header, value of res.headers
            resHeaders[header.toLowerCase()] = value
        validate.call @, res, resHeaders  for validate in @_validators
      @_flag.store = !!@_flag.store
      @_addStoreID req, res, resHeaders  if @_flag.store
      @_flag
