###
Parts
nodejs-secure-random
https://github.com/my8bird/nodejs-secure-random
Copyright (c) 2013, Nathan Landis
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the nodejs-secure-random nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###

define = require('amdefine')(module)  if typeof define isnt 'function'
define [
  '../NodeJS/buffer'
  '../NodeJS/crypto'
], (
  Buffer
  Crypto
) ->
  "use strict"

  random = (type, options) ->
    switch type
      when 'number'
        random._getNumber options
      when 'integer', 'int'
        random._getInteger options
      when 'boolean', 'bool'
        random._getBoolean options
      when 'string'
        random._getString options


  # maxNumber = Math.pow(2, 53) - 1
  # minNumber = maxNumber * -1
  # we need bitwise operations, see http://notepad2.blogspot.se/2012/04/maximum-integer-in-javascript.html
  random._maxNumber = Math.pow(2, 31) - 1
  random._minNumber = random._maxNumber * -1

  # BEGIN from https://github.com/my8bird/nodejs-secure-random/blob/master/random.js
  #
  random._mapToRange = (min, max, randomUInt) ->
    resultRange = (max + 1) - min
    factor = resultRange / random._maxNumber
    ((randomUInt * factor) + min) >> 0 # bitshifting by zero equates to Math.floor, albeit faster.

  random._getIntSuper = (min, max) ->
    unsignedInt = undefined
    randomInt = undefined

    bytesSlowBuf = Crypto.randomBytes 8
    unsignedInt = Buffer.Buffer(bytesSlowBuf).readUInt32LE 0
    if typeof min isnt 'undefined' or typeof max isnt 'undefined'
      min ?= random._minNumber
      max ?= random._maxNumber
      max = min  if min > max
      randomInt = random._mapToRange min, max, unsignedInt
    else
      randomInt = unsignedInt
    randomInt
  #
  # END from https://github.com/my8bird/nodejs-secure-random/blob/master/random.js


  # WARNING. superRandom is ~3 times slower
  random._getInt = (min, max, superRandom = false) ->
    return  random._getIntSuper min, max  if superRandom

    min ?= random._minNumber
    max ?= random._maxNumber
    max = min  if min > max
    return Math.floor(Math.random() * (max - min + 1)) + min


  random._getNumber = (options) ->
    options ?= {}
    options.minimum ?= random._minNumber
    options.minimum = random._minNumber  if options.minimum < random._minNumber
    options.maximum ?= random._maxNumber
    options.maximum = random._maxNumber  if options.maximum > random._maxNumber
    options.divisibleBy ?= 1
    options.decimals ?= 0
    options.decimals = 0  if options.decimals < 0
    options.base ?= 10

    if options.divisibleBy isnt 1
      options.maximum = parseInt(options.maximum / options.divisibleBy)

    randomInt = random._getInt options.minimum, options.maximum, options.superRandom

    if options.divisibleBy isnt 1
      randomInt = randomInt * options.divisibleBy

    if options.decimals isnt 0
      randomInt = randomInt / Math.pow(10, options.decimals)

    if options.base isnt 10
      randomInt = randomInt.toString options.base
    randomInt


  random._getInteger = (options = {}) ->
    options.decimals = 0
    random._getNumber options


  random._getBoolean = (options = {}) ->
    options.minimum = 0
    options.maximum = 1
    Boolean random._getInteger options


  random._getString = (options) ->
    options ?= {}
    options.minLength ?= 0
    options.minLength = 0  if options.minLength < 0
    options.maxLength ?= 255
    options.maxLength = 255  if options.maxLength > 255
    options.maxLength = options.minLength  if options.minLength > options.maxLength
    options.useDigits ?= true
    options.useUpperCase ?= true
    options.useLowerCase ?= true

    digits = '1234567890'
    upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    lowerCase = 'abcdefghijklmnopqrstuvwxyz'

    possibleChars = ''
    possibleChars += digits  if options.useDigits
    possibleChars += upperCase  if options.useUpperCase
    possibleChars += lowerCase  if options.useLowerCase
    possibleChars ?= digits + upperCase + lowerCase

    length = random._getNumber {minimum: options.minLength, maximum: options.maxLength}

    result = ''
    for i in [1..length]
      result += possibleChars.charAt random._getInt(0, possibleChars.length-1)
    result

  random
