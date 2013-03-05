define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './LinkHeader'
], (
  _
  LinkHeader
) ->
  "use strict"

  # Get links from Link header
  (linkHeader) ->
    linkHeader = new LinkHeader linkHeader  unless linkHeader instanceof LinkHeader
    # anchor, rel
    # The "hreflang", "media", "title", "title*", "type", and any link-extension link-params are considered to be target attributes for the link.
    result = []
    for token in linkHeader.tokens
      link = _.cloneDeep token
      if link.anchor
        # FIXME resolve href on anchor
        link.href = link.href
        delete link.anchor
      if link['title*']
        link.title = link['title*']
        delete link['title*']
      result.push link
    result
