define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './FluentInterface'
], (
  _
  FluentInterface
) ->
  "use strict"

  class AsyncFluentInterface extends FluentInterface
    self = @
    sup = self.__super__
    _chainableActions: [] # funs to replace with a fluent equivalent

    ####

    constructor: (context = {}) ->
      return new AsyncFluentInterface(context)  unless @ instanceof AsyncFluentInterface

      @_chainableActions = @_chainableActions.concat ['each', 'map']
      for superAction in ['get', 'eq', 'end']
        @[superAction] = @_makeSuperActionAsync superAction
      @_maybeStartActionChain = _.async @_maybeStartActionChain, @
      @callNextAction = _.async @callNextAction, @
      #
      context = _.merge {
        actionChain: []
        actionChainPos: -1
      }, context

      super context
      for chainableAction in @_chainableActions
        originalAction = @[chainableAction]
        @[chainableAction] = @_makeChainAction @[chainableAction]
        @[chainableAction].original = originalAction

    ####

    _maybeStartActionChain: () ->
      return  if @context 'isActionOngoing'
      @context 'isActionOngoing', true
      @callNextAction()


    _isAsync: () ->
      return @context('isActionOngoing') or @context('actionChain').length


    _maybeEndActionChain: () ->
      @context 'isActionOngoing', (@context('actionChain').length isnt 0)

    ####

    _defaultAction: (callback) ->
      {next, err, resp} = callback
      next err, resp


    _defaultActionCallback: (err, resp) ->
      @callNextAction err, resp


    chainAction: (fun, callback, args...) ->
      @context('actionChain').push
        fun: fun
        callback: callback or @_defaultActionCallback
        args: args
      @


    _makeChainAction: (fun) ->
      _.bind @chainAction, @, fun, @_defaultActionCallback

    ####

    _getComingInterface: (resp) ->
      respInterface = @
      respInterface = resp  if resp instanceof AsyncFluentInterface
      respInterface


    _makeActionNext: (action) ->
      (err, resp) =>
        $ = @_getComingInterface resp
        return $.callNextAction err  unless action.callback
        @_maybeEndActionChain()
        asyncCallback = _.async action.callback, $
        asyncCallback err, resp, $.callNextAction


    callNextAction: (err, resp) ->
      actionChain = @context 'actionChain'
      @_maybeEndActionChain()
      return   unless actionChain.length

      action = actionChain.shift()
      $ = @_getComingInterface resp
      comingNext = @_makeActionNext action

      args = action.args.concat []
      args[action.fun.length-1] = {
        next: comingNext
        err: err
        resp: resp
      }

      action.fun.apply $, args

    ####

    _makeSuperActionAsync: (funName) ->
      (args...) =>
        return sup[funName].apply @, args  unless @_isAsync()

        _placeholderAction = (args, callback) ->
          {next, err, resp} = callback
          return next err  if err
          next null, sup[funName].apply @, args
        @chainAction _placeholderAction, null, args


    each: (iterator, context, callback) ->
      {next, err, resp} = callback
      return next err  if err
      _.eachAsync @, next, iterator, context


    map: (iterator, context, callback) ->
      {next, err, resp} = callback
      return next err  if err
      next2 = (err, resp) =>
        return next err  if err
        next null, @pushStack resp
      _.mapAsync @, next2, iterator, context

    ####

    _callbackAction: (callback) ->
      {next, err, resp} = callback
      @_maybeEndActionChain()
      next err, resp


    callback: (callback) ->
      @chainAction @_callbackAction, callback
      @_maybeStartActionChain()
      undefined

    ####

    promise: () ->
      dfd = new _.Deferred
      @chainAction @_defaultAction, (err, resp) =>
        dfd.reject err  if err
        dfd.resolve resp
      @_maybeStartActionChain()
      dfd.promise()
