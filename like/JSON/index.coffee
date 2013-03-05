define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './getLinksFromCollectionJSON'
  './getLinksFromHAL'
  './getLinksFromJSON'
  './getLinksFromJSONLinks'
  './getLinksFromSiren'
  './pointer'
  './safe'
  './unsafe'
], (
  getLinksFromCollectionJSON
  getLinksFromHAL
  getLinksFromJSON
  getLinksFromJSONLinks
  getLinksFromSiren
  pointer
  safe
  unsafe
) ->
  "use strict"

  {
    getLinksFromCollectionJSON
    getLinksFromHAL
    getLinksFromJSON
    getLinksFromJSONLinks
    getLinksFromSiren
    pointer
    safe
    unsafe
  }
