define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  './_'
  './FluentInterface'
], (
  _
  FluentInterface
) ->
  class AsyncFluentInterface extends FluentInterface
    self = @
    sup = self.__super__

    _defaultContext:
      actionChain: []
      isActionOngoing: false
    _chainableActions: [] # funs to replace with a fluent equivalent

    ####

    constructor: (context) ->
      @_chainableActions = @_chainableActions.concat ['each', 'map']
      for superAction in ['get', 'eq', 'end']
        @[superAction] = @_makeSuperActionAsync superAction
      @_maybeStartActionChain = _.async @_maybeStartActionChain, @
      @callNextAction = _.async @callNextAction, @
      #
      super
      for chainableAction in @_chainableActions
        @[chainableAction] = @_makeChainAction @[chainableAction]

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
        #return $.callNextAction err  unless action.callback
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
      argsPos = action.fun.length-3
      args[argsPos] = comingNext
      args[argsPos+1] = err
      args[argsPos+2] = resp
      #args = action.args.concat [comingNext, err, resp]

      action.fun.apply $, args

    ####

    _makeSuperActionAsync: (funName) ->
      (args...) =>
        return sup[funName].apply @, args  unless @_isAsync()

        _placeholderAction = (args, next, err, resp) ->
          return next err  if err
          next null, sup[funName].apply @, args
        @chainAction _placeholderAction, null, args


    each: (iterator, context, callback, err, resp) ->
      return callback err  if err
      _.eachAsync @, callback, iterator, context


    map: (iterator, context, callback, err, resp) ->
      return callback err  if err
      callback2 = (err, resp) =>
        return callback err  if err
        callback null, @pushStack resp
      _.mapAsync @, callback2, iterator, context

    ####

    _callback: (next, err, resp) ->
      return next err  if err
      next null, resp


    callback: (callback) ->
      @chainAction @_callback, callback
      @_maybeStartActionChain()
      @

    ####

    _promise: (next, err, resp) ->
      return next err  if err
      next null, @


    promise: () ->
      dfd = new _.Deferred
      @chainAction @_promise, (err, resp) =>
        dfd.reject err  if err
        dfd.resolve resp
      @_maybeStartActionChain()
      dfd.promise()
