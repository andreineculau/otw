/*jshint node:true*/
if (typeof define !== 'function') {var define = require('amdefine')(module);}

define(function() {
    'use strict';
    /**
     * Replace all Unicode characters with their safeJSON (escaped) equivalent
     */
    return function(str, pattern) {
        pattern = pattern || /[\u007f-\uffff]/g;
        str = str.replace(pattern, function(c) {
            return '\\u' + ('0000' + c.charCodeAt(0).toString(16)).slice(-4);
        });
        return str;
    };
});
