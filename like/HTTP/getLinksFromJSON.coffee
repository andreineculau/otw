define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './getLinksFromCollectionJSON'
  './getLinksFromHAL'
  './getLinksFromJSONLinks'
  './getLinksFromSiren'
], (
  _
  getLinksFromCollectionJSON
  getLinksFromHAL
  getLinksFromJSONLinks
  getLinksFromSiren
) ->
  "use strict"

  # Get links from a JSON object
  (obj = {}, format = '') ->
    format = String(format or '').toLowerCase()
    switch format
      when 'collection' then fun = getLinksFromCollectionJSON
      when 'hal' then fun = getLinksFromHAL
      when 'siren' then fun = getLinksFromSiren
      else fun = getLinksFromJSONLinks
    links = fun obj
    links
