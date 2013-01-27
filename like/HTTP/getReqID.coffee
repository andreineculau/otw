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

  Crypto = require 'crypto' # FIXME

  # Get a unique request ID (based on method, URI and vary headers)
  (req, vary = []) ->
    method = getNormalizedMethod req.method
    URI = getNormalizedURI req.url, {query: true}
    hash = [
      method
      URI
    ]
    if vary.length
      reqHeaders = getNormalizeHeaders req.headers
      hash.push [token, reqHeaders[token]].join '='  for token in vary
    hash = hash.join '\n'
    hash = Crypto.createHmac('SHA256', method + URI).update(hash).digest('base64')
    hash
