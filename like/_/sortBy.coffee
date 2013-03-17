# Parts
# Underscore.js 1.4.4
# http://underscorejs.org
# (c) 2009-2013 Jeremy Ashkenas, DocumentCloud Inc.

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './lookupIterator'
  './map'
  './pluck'
], (
  _lookupIterator
  _map
  _pluck
) ->
  "use strict"

  (obj, value, context) ->
    iterator = _lookupIterator value
    _pluck _map(obj, (value, index, list) ->
      value: value
      index: index
      criteria: iterator.call context, value, index, list
    ).sort((left, right) ->
      a = left.criteria
      b = right.criteria
      if a isnt b
        return 1  if a > b or a is undefined
        return -1  if a < b or b is undefined
      (if left.index < right.index then -1 else 1)
    ), "value"
