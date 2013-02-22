define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  '../NodeJS/crypto'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getNormalizedHeaders'
], (
  _
  Crypto
  getNormalizedMethod
  getNormalizedURI
  getNormalizedHeaders
) ->
  "use strict"

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
