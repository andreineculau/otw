define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './AcceptHeader'
  './ContentTypeHeader'
  './LinkHeader'
  './TokenizedHeader'
], (
  AcceptHeader
  ContentTypeHeader
  LinkHeader
  TokenizedHeader
) ->
  "use strict"
  {
    AcceptHeader: AcceptHeader
    ContentTypeHeader: ContentTypeHeader
    LinkHeader: LinkHeader
  }
