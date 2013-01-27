define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './CacheResponseValidator'
  './CacheRequestValidator'
  './CacheStorageInMemory'
], (
  _
  CacheResponseValidator
  CacheRequestValidator
  CacheStorageInMemory
) ->
  "use strict"

  # Reference
  # https://github.com/mikeal/request/pull/20
  # https://github.com/ithinkihaveacat/node-fishback
  # https://github.com/d11wtq/node-http-cache
  # http://mnot.github.com/redbot/

  # Cache
  class Cache
    self = @
    _cache: undefined
    config: undefined

    constructor: (config = {}) ->
      # Shortcuts
      _.configOption.call @, configOption  for configOption in [
        'cacheRequestValidator'
        'cacheResponseValidator'
        'storage'
      ]

      defaultConfig =
        cacheResponseValidator: undefined
        cacheRequestValidator: undefined
        storage: undefined
      @config = _.merge defaultConfig, config

      @cacheRequestValidator ?= new CacheRequestValidator
      @cacheResponseValidator ?= new CacheResponseValidator
      @storage ?= new CacheStorageInMemory

    _retrieve: (cacheRequest, req) ->
      # If this request is not retrievable (cacheable)
      unless cacheRequest.canRetrieve
        # Erase cache
        @storage.eraseForURI URI
        return false

      # If this request is to be transparent
      if cacheRequest.disposition in ['STALE', 'TRANSPARENT']
        return false

      # Is there any cache for the request's URI ?
      cacheForURI = @storage.getForURI URI
      return false  unless cacheForURI.length

      for cacheItem in cacheForURI
        cacheID = getReqID req, cacheItem.reqVary
        return cacheItem  if cacheID = cacheItem.reqID

    # Handle request
    request: (req, doRequest, callback) ->
      URI = getReqURI req, {query: true}
      cacheRequest = @cacheRequestValidator.test req
      cacheItem = @_canHandleReq cacheRequest, req

      # TODO cache disposition STALE ?

      if cacheItem is false
        if cacheRequest.disposition is 'FRESH'
          # TODO only-from-cache but nothing cached
        else
          doRequest req, (err, res) ->
            cacheResponse = @CacheResponseValidator.test req, res
            @storage.store cacheResponse  if cacheResponse.canStore
            callback err, res
      else
        # TODO act as proxy?
        # TODO change res - act as proxy ?
        # TODO cache disposition STALE ?
        cacheItem.lastAccessedTime = new Date().getTime()
        cacheItem.accessCount += 1
        @storage.update cacheItem
        callback null, cacheItem.res

    erase: (callback) ->
      callback ?= () -> true
      @storage.erase callback
