define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './type'
  './extendDeep'
], (
  _type
  _extendDeep
)->
  "use strict"
  (args...) ->
    deep = undefined
    if args.length > 1 and _type(args[0]) is 'boolean'
      deep = args[0]
      args.splice 0, 1
    if _type(args[0]) is 'array'
      base = []
    else if _type(args[0]) is 'object'
      base = {}
    else
      base = args.pop()
      return base.clone()  if _type(base.clone) is 'function'
      return base  unless typeof base is 'object'
      copy = base.constructor()
      for attr of base
        continue  unless Object.prototype.hasOwnProperty base, attr
        copy[attr] = base[attr]
      return copy

    args.unshift base
    if _type(deep) isnt 'undefined'
      args.unshift deep
    _extendDeep.apply _, args
