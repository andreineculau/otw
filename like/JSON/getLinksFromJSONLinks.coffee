define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Get links from a JSON object's links
  (obj = {}) ->
    links = obj.links
    links or= []
    if _.type(links) is 'array' and links.length
      for link in links
        return  unless _.type(link) is 'object' and link.rel and link.href
      links = _.clone links, true
    links = undefined  unless links and links.length
    links
