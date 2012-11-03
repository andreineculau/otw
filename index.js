/*jshint node:true*/
if (typeof define !== 'function') {var define = require('amdefine')(module);}

define([
    './src/type'
], function(
    type
) {
    'use strict';
    return {
        type: type
    };
});
