# Parts
# Underscore.js 1.4.4
# http://underscorejs.org
# (c) 2009-2013 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './has'
], (
  _has
) ->
  "use strict"
  nativeKeys = Object::keys

  nativeKeys or (obj) ->
    throw new TypeError('Invalid object')  if obj isnt Object(obj)
    keys = []
    for key of obj
      keys[keys.length] = key  if _has obj, key
    keys
