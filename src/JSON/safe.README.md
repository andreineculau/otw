# JSON.safe (One Thing Well)

## Why?

JSON is Unicode enabled, but in certain situations you can only send non-Unicode text.


## Usage

```javascript
var safeJSON = require('otw/src/JSON.safe');

safeJSON('åäö'); // \u00e5\u00e4\u00f6'
```
