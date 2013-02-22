define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  exports = {}

  traverse = (obj, pointer, callbackSet, callbackInnerSet) ->
    part = pointer.shift()
    [type, key] = part
    key = unescape key
    return obj  if key is ''

    unless typeof obj is 'object' and key of obj
      throw new Error('Pointer path is invalid')  unless typeof obj is 'object'
      callbackInnerSet obj, part  if typeof callbackInnerSet isnt 'undefined'
      throw new Error('Pointer path does not exist')  unless key of obj
    # keep traversin!
    return traverse(obj[key], pointer, callbackSet, callbackInnerSet)  if pointer.length isnt 0
    previousValue = obj[key]
    callbackSet obj, part  if typeof callbackSet isnt 'undefined'
    previousValue


  validateInput = (obj, pointer) ->
    throw new Error('Invalid input - object or array needed.')  if typeof obj isnt 'object'
    throw new Error('Invalid JSON pointer.')  unless pointer


  parseReference = (reference) ->
    reference = reference.replace /\]/g, ''
    result  = []
    re = /[\[\.]?([^\[\.]+)/g
    while (match = re.exec reference) isnt null
      type = 'object'
      type = 'array'  if match[0][0] is '['
      result.push [type, match[1]]
    result


  parsePointer = (pointer) ->
    # maybe reference
    return parseReference(pointer)  if pointer[0] isnt '/'
    pointer = pointer.substring(1)
    pointer = pointer.split '/'
    result = []
    result.push ['unknown', item]  for item in pointer
    result


  exports.get = (obj, pointer) ->
    pointer ?= '/'
    return obj  unless pointer and pointer isnt '/'

    validateInput obj, pointer
    pointer = parsePointer pointer
    try
      return  traverse obj, pointer
    catch e
      return undefined


  exports.has = (obj, pointer) ->
    validateInput obj, pointer
    pointer = parsePointer pointer
    try
      traverse obj, pointer
      return true
    catch e
      return false


  exports.set = (obj, pointer, value, createPath) ->
    validateInput obj, pointer
    pointer = parsePointer pointer
    callbackSet = (obj, [type, key]) -> obj[key] = value
    if createPath
      callbackInnerSet = (obj, [type, key]) ->
        obj[key] = {}  if type is 'object'
        obj[key] = []  if type is 'array'
    traverse obj, pointer, callbackSet, callbackInnerSet


  exports.setCallback = (obj, pointer, callbackSet, callbackInnerSet) ->
    validateInput obj, pointer
    pointer = parsePointer pointer
    traverse obj, pointer, callbackSet, callbackInnerSet


  exports.remove = (obj, pointer) ->
    try
      exports.setCallback obj, pointer, (obj, [type, key]) ->
        obj.splice key, 1  if obj instanceof Array
        delete obj[key]
    catch e

  exports
