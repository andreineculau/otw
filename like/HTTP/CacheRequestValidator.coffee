define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getNormalizedHeaders'
], (
  _
  getNormalizedMethod
  getNormalizedURI
  getNormalizedHeaders
) ->
  "use strict"

  url = require 'url' # FIXME

  # Validate if a HTTP request should be served from a cache storage
  class CacheRequestValidator
    self = @
    _validators: undefined
    _context: undefined
    config: undefined

    constructor: (config = {}) ->
      # Shortcuts
      _.configOption.call @, configOption  for configOption in [
        'sharedCache'
        'cacheQueries'
      ]
      _.configOption.call @, configOption, {}, '_context'  for configOption in [
        '_canRetrieve'
        '_sinceTime'
        '_disposition'
        '_reqMethod'
        '_reqURI'
        '_reqHeaders'
      ]

      defaultConfig =
        privateCache: false
        queryCache: false
      @config = _.merge defaultConfig, config

      @_validators = [
        @_isntMaxAgeZero
        @_isntNoCache
        @_hasntAuthorization
        @_hasntQuery
        @_isSafeMethod
        @_hasIfModifiedSince
        @_isOnlyIfCached
      ]

    _setRetrieve: (flag) ->
      return  unless _.type(@_canRetrieve) is 'undefined'
      @_canRetrieve = !!flag

    _setSince: (timestamp) ->
      @_sinceTime = timestamp  if timestamp > @_sinceTime

    _DISPOSITION_FLAGS: [
      'FRESH'
      'STALE'
      'TRANSPARENT'
    ]

    _setDisposition: (flag) ->
      return  unless flag in @_DISPOSITION_FLAGS
      @_disposition = flag

    # RFC 2616 Section 13.1.6
    _isntMaxAgeZero: () ->
      return  unless /max-age=(0|-[0-9]+)/.test(@_reqHeaders['cache-control'] or '')
      # @_setRetrieve false
      @_setDisposition 'TRANSPARENT'
      @_setSince new Date().getTime()

    # RFC 2616 Section 14.9
    _isntNoCache: () ->
      return  unless /no-cache/.test(@_reqHeaders['cache-control'] or '') or /no-cache/.test(@_reqHeaders['pragma'] or '')
      # @_setRetrieve false
      @_setDisposition 'TRANSPARENT'

    # RFC 2616 Section 13.4
    _hasntAuthorization: () ->
      return  if @privateCache
      return  unless @_reqHeaders['authorization']
      @_setRetrieve false

    # RFC 2616 Section 13.9
    _hasntQuery: () ->
      return  if @queryCache
      return  unless url.parse(@_reqURI).query
      @_setRetrieve false

    # RFC 2616 Section 13.9
    _isSafeMethod: () ->
      return  unless @_reqMethod in ['HEAD', 'GET']
      @_setRetrieve true

    _hasIfModifiedSince: () ->
      return  unless @_reqHeaders['if-modified-since']
      @_setSince new Date(@_reqHeaders['if-modified-since'])

    # RFC 2616 Section 14.9.4
    _isOnlyIfCached: () ->
      return  unless /only-if-cached/.test(@_reqHeaders['cache-control'] or '')
      @_setDisposition 'FRESH'

    test: (req) ->
      @_context =
        _canRetrieve: undefined
        _sinceTime: new Date().getTime() - 60 * 60 * 24 * 365.25 # RFC - caching should not exceed one year from now
        _disposition: undefined
        _reqMethod: getNormalizedMethod req.method
        _reqURI: getNormalizedURI(req.url, {query: true})
        _reqHeaders: getNormalizedHeaders req.headers

      validate.call @  for validate in @_validators
      @_canRetrieve = !!@_canRetrieve

      result = {}
      result[key.substr(1)] = value  for key, value of @_context
      delete @_context
      result
