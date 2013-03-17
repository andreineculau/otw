# Parts
# Underscore.js 1.4.4
# http://underscorejs.org
# (c) 2009-2013 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './keys'
], (
  _keys
) ->
  "use strict"

  (obj) ->
    return 0  unless obj
    return obj.length  if obj.length is +obj.length
    _keys(obj).length
