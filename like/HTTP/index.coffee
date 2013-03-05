define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AcceptHeader'
  './ContentTypeHeader'
  './getLinksFromCollectionJSON'
  './getLinksFromHAL'
  './getLinksFromHeaders'
  './getLinksFromJSON'
  './getLinksFromJSONLinks'
  './getLinksFromSiren'
  './getNormalizedHeaders'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getReqID'
  './LinkHeader'
  './TokenizedHeader'
], (
  AcceptHeader
  ContentTypeHeader
  getLinksFromCollectionJSON
  getLinksFromHAL
  getLinksFromHeaders
  getLinksFromJSON
  getLinksFromJSONLinks
  getLinksFromSiren
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
    getLinksFromCollectionJSON
    getLinksFromHAL
    getLinksFromHeaders
    getLinksFromJSON
    getLinksFromJSONLinks
    getLinksFromSiren
    getNormalizedHeaders
    getNormalizedMethod
    getNormalizedURI
    getReqID
    LinkHeader
    TokenizedHeader
  }
