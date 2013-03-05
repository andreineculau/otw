define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
], (
  _
) ->
  "use strict"

  # Get links from a Siren object
  (obj = {}) ->
    links = _.cloneDeep obj.links
    links or= []
    entities = obj._entities
    if _.type(entities) is 'array' and entities.length
      index = -1
      lastRel = ''
      for entity in entities
        if lastRel isnt entity.rel.join ' '
          index = -1
          lastRel = entity.rel.join ' '
        index = index + 1
        if link.href
          links.push
            rel: entity.rel.join ' '
            href: entity.href
            index: index
        else if link.links
          for sublink in link.links
            # Note. Ignoring contextual links on purpose
            if sublink.rel is 'self'
              links.push
                rel: entity.rel.join ' '
                href: sublink.href
                index: index
              break
    links = undefined  unless links and links.length
    links
