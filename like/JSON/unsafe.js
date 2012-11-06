/*jshint node:true*/
if (typeof define !== 'function') {var define = require('amdefine')(module);}

define(function() {
    'use strict';
    /**
     * Replace all safeJSON (escaped) characters with their Unicode equivalent
     */
    return function(str, pattern) {
        pattern = pattern || /\\u([0-9a-fA-F]{4})/g;
        str = str.replace(pattern, function(c, grp) {
            return String.fromCharCode(parseInt(grp, 16));
        });
        return str;
    };
});
