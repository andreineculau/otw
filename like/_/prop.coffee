define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"
  (name, desc = {}) ->
    desc.configurable = true
    desc.get ?= () ->
      return @["_#{name}"]
    desc.set ?= (value) ->
      @["_#{name}"] = value
    Object.defineProperty @prototype, name, desc
