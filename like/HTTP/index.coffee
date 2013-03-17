define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AcceptCharsetHeader'
  './AcceptEncodingHeader'
  './AcceptHeader'
  './AcceptLanguageHeader'
  './ContentTypeHeader'
  './getLinksFromHeaders'
  './getNormalizedHeaders'
  './getNormalizedMethod'
  './getNormalizedURI'
  './getReqID'
  './LinkHeader'
  './TokenizedHeader'
], (
  AcceptCharsetHeader
  AcceptEncodingHeader
  AcceptHeader
  AcceptLanguageHeader
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
    AcceptCharsetHeader
    AcceptEncodingHeader
    AcceptHeader
    AcceptLanguageHeader
    ContentTypeHeader
    getLinksFromHeaders
    getNormalizedHeaders
    getNormalizedMethod
    getNormalizedURI
    getReqID
    LinkHeader
    TokenizedHeader
  }
