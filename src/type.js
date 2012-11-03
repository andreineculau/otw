/*jshint node:true*/
if (typeof define !== 'function') {var define = require('amdefine')(module);}

define(function() {
    'use strict';
    /**
     * typeof replacement
     */
    return function(obj) {
        if (obj === null || obj === undefined) {
            return String(obj);
        }
        return Object.prototype.toString.call(obj).slice(8, -1).toLowerCase() || 'object';
    };
});
