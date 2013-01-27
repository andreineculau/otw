define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AcceptHeader'
  './ContentTypeHeader'
  './getNormalizedHeaders'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getReqID'
  './LinkHeader'
  './TokenizedHeader'
], (
  AcceptHeader
  ContentTypeHeader
  getNormalizedHeaders
  getNormalizedMethod
  getNormalizedURI
  getReqID
  LinkHeader
  TokenizedHeader
) ->
  "use strict"

  {
    AcceptHeader: AcceptHeader
    ContentTypeHeader: ContentTypeHeader
    getNormalizedHeaders: getNormalizedHeaders
    getNormalizedMethod: getNormalizedMethod
    getNormalizedURI: getNormalizedURI
    getReqID: getReqID
    LinkHeader: LinkHeader
    TokenizedHeader: TokenizedHeader
  }
