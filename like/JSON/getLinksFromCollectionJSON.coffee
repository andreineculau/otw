define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Get links from a Collection+JSON object
  (obj = {}) ->
    links = obj.collection?.links
    links or= []
    if _.type(links) is 'array' and links.length
      for link in links
        return  unless _.type(link) is 'object' and link.rel and link.href
      links = _.clone links, true
    items = obj.items
    if _.type(items) is 'array' and items.length
      links or= []
      index = -1
      for item in items
        links.push
          rel: 'item'
          href: item.href
          index: index
        # Note. Ignoring contextual links on purpose
    links = undefined  unless links and links.length
    links
