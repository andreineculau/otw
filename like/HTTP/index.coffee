define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AcceptHeader'
  './ContentTypeHeader'
  './getLinksFromHeaders'
  './getNormalizedHeaders'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getReqID'
  './LinkHeader'
  './TokenizedHeader'
], (
  AcceptHeader
  ContentTypeHeader
  getLinksFromHeaders
  getNormalizedHeaders
  getNormalizedMethod
  getNormalizedURI
  getReqID
  LinkHeader
  TokenizedHeader
) ->
  "use strict"

  {
    AcceptHeader
    ContentTypeHeader
    getLinksFromHeaders
    getNormalizedHeaders
    getNormalizedMethod
    getNormalizedURI
    getReqID
    LinkHeader
    TokenizedHeader
  }
