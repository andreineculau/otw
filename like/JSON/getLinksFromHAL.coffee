define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Get links from a HAL object
  (obj = {}) ->
    # Note. Ignoring contextual links on purpose
    links = []
    for linkRel, sublinks of obj._links
      return  unless linkRel
      sublinks = [sublinks]  if _.type(sublinks) is 'object'
      for link in sublinks
        return  unless _.type(link) is 'object' and link.href
        link = _.clone link, true
        link.rel = linkRel
        links.push link
    links = undefined  unless links and links.length
    links
