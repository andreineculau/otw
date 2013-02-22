define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './CacheRequestValidator'
  '../NodeJS/crypto'
  './getNormalizedHeaders'
  './getReqID'
  './TokenizedHeader'
], (
  _
  CacheRequestValidator
  Crypto
  getNormalizedHeaders
  getReqID
  TokenizedHeader
) ->
  "use strict"

  # Validate if a HTTP response can be cached
  class CacheResponseValidator
    self = @
    _validators: undefined
    _context: undefined
    config: undefined

    constructor: (config = {}) ->
      # Shortcuts
      _.configOption.call @, configOption  for configOption in [
        'userAgent'
      ]
      _.configOption.call @, configOption, {}, '_context'  for configOption in [
        '_canStore'
        '_expiresTime'
        '_reqID'
        '_reqMethod'
        '_reqURI'
        '_reqHeaders'
        '_res'
        '_resHeaders'
        '_resVary'
        '_lastFetchedTime'
        '_lastAccessedTime'
        '_accessCount'
      ]

      defaultConfig =
        userAgent: false
      @config = _.merge defaultConfig, config

      @_cacheRequestValidator = new CacheRequestValidator
      @_validators = [
        @_isntPrivate
        @_isntNoStore
        @_isntMaxAgeZero
        @_isMaxAgeFuture
        @_hasExpires
        @_hasLastModified
        @_hasCacheableStatusCode
      ]

    _setStore: (flag) ->
      return  unless _.type(@_canStore) is 'undefined'
      @_canStore = !!flag

    _setExpires: (timestamp) ->
      @_expiresTime = timestamp  if timestamp < @_expiresTime

    # RFC 2616 Section 14.9
    _isntPrivate: () ->
      @_setStore false  if !@userAgent and /private/.test(@_resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isntNoStore: () ->
      @_setStore false  if /no-store(?!=)/.test(@_resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isntMaxAgeZero: () ->
      @_setStore false  if /max-age=(0|-[0-9]+)/.test(@_resHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isMaxAgeFuture: () ->
      matches = /max-age=([0-9]+)/.exec(@_resHeaders['cache-control'] or '')
      return  unless matches
      @_setStore true
      @_setExpires new Date().getTime() + matches[1]

    _hasExpires: () ->
      return  unless @_resHeaders['expires']
      @_setStore true
      @_setExpires new Date(@_resHeaders['expires'])

    # RFC 2616 Section 13.3.1
    _hasLastModified: () ->
      @_setStore true  if @_resHeaders['last-modified']

    # RFC 2616 Section 13.4
    _CACHEABLE_STATUS_CODES:
      200: 'OK'
      203: 'Non-Authoritative Information'
      300: 'Multiple Choices'
      301: 'Moved Permanently'
      401: 'Unauthorized'

    _hasCacheableStatusCode: () ->
      @_setStore true  if @_res.statusCode of @_CACHEABLE_STATUS_CODES

    test: (req, res) ->
      cacheRequest = @_cacheRequestValidator.test req

      resHeaders = getNormalizedHeaders res.headers
      resVary = []
      if resHeaders['vary']
        vary = new TokenizedHeader resHeaders['vary']
        resVary.push token.toLowerCase()  for token of vary.tokens[0]

      @_context =
        _canStore: undefined
        _expiresTime: new Date().getTime() + 60 * 60 * 24 * 365.25 # RFC - caching should not exceed one year from now
        _reqID: getReqID req, resVary
        _reqMethod: cacheRequest.reqMethod
        _reqURI: cacheRequest.reqURI
        _reqHeaders: cacheRequest.reqHeaders
        _res: res
        _resHeaders: resHeaders
        _resVary: resVary
        _lastFetchedTime: new Date(resHeaders['date']).getTime()
        _lastAccessedTime: new Date().getTime()
        _accessCount: 1

      if cacheRequest.canRetrieve
        validate.call @  for validate in @_validators
      @_canStore = !!@_canStore

      result = {}
      result[key.substr(1)] = value  for key, value of @_context
      delete @_context
      result
