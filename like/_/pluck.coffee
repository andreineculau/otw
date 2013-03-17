# Parts
# Underscore.js 1.4.4
# http://underscorejs.org
# (c) 2009-2013 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './map'
], (
  _map
) ->
  "use strict"

  (obj, key) ->
    _map obj, (value) -> value[key]
