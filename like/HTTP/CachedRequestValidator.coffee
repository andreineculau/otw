define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Validate if a HTTP request should be served from a cache storage
  class CachedRequestValidator
    self = @
    _validators: undefined
    _flag: undefined

    constructor: () ->
      @_validators = [
        @_isntMaxAgeZero
        @_isntNoCache
        @_isntNoStore
        @_isSafeMethod
        @_hasIfModifiedSince
      ]

    retrieve: (flag) ->
      return  unless _.type(@_flag.retrieve) is 'undefined'
      @_flag.retrieve = !!flag

    modified: (timestamp) ->
      @_flag.since = timestamp  if timestamp > @_flag.since

    # RFC 2616 Section 13.1.6
    _isntMaxAgeZero: (req, reqHeaders) ->
      @retrieve false  if /max-age=(0|-[0-9]+)/.test(reqHeaders['cache-control'] or '')

    # RFC 2616 Section 14.9
    _isntNoCache: (req, reqHeaders) ->
      @retrieve false  if /no-cache/.test(reqHeaders['cache-control'] or '')
      @retrieve false  if /no-cache/.test(reqHeaders['pragma'] or '')

    # RFC 2616 Section 14.9
    _isntNoStore: (req, reqHeaders) ->
      @retrieve false  if /no-store(?!=)/.test(reqHeaders['cache-control'] or '')

    _isSafeMethod: (req, reqHeaders) ->
      method = req.method or ''
      @retrieve true  if method.toUpperCase() in ['HEAD', 'GET']

    _hasIfModifiedSince: (req, reqHeaders) ->
      return  unless reqHeaders['if-modified-since']
      @modified new Date(reqHeaders['if-modified-since'])

    test: (req, res) ->
      @_flag =
        retrieve: undefined
        since: new Date().getTime() - 60 * 60 * 24 * 365.25 # RFC - caching should not exceed one year from now
      reqHeaders = {}
      if req.headers
        for header, value of req.headers
          reqHeaders[header.toLowerCase()] = value
      validate.call @, req, reqHeaders  for validate in @_validators
      @_flag.retrieve = !!@_flag.retrieve
      @_flag
