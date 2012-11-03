# type (One Thing Well)

## Why?

Read <http://javascriptweblog.wordpress.com/2011/08/08/fixing-the-javascript-typeof-operator>
and <http://perfectionkills.com/instanceof-considered-harmful-or-how-to-write-a-robust-isarray>
and other literature.

Don't use `instanceof`, and also not `typeof`.


## Usage

```javascript
var type = require('otw/src/type');

type({a: 4});    // 'object
type([1, 2, 3]); // 'array'
type(new Date);  // 'date'
type(/a-z/);     // 'regexp'
type(Math);      // 'math'
type(JSON);      // 'json'

type(new Number(4));      // 'number'
type(new String('abc'));  // 'string'
type(new Boolean(true));  // 'boolean'
type(new ReferenceError); // 'error'

(function() {console.log(type(arguments))})(); // 'arguments'
```
