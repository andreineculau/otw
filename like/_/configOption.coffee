define = require('amdefine')(module)  if typeof define isnt 'function'
define ->
  "use strict"

  (name, desc = {}, config = 'config') ->
    desc.configurable = true
    desc.get ?= () -> @[config][name]
    desc.set ?= (value) -> @[config][name] = value
    Object.defineProperty @, name, desc
