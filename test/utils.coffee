chai = require 'chai'
chai.Assertion.includeStack = true

exports.should = chai.should()
exports._ = {
}

console.jog = (arg) ->
  console.log JSON.stringify arg
