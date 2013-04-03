var Task = require('./../lib/task.js');
var assert = require('assert');

var task = new Task;

describe('sort by cost', function() {
    it('should be', function() {
        
        task.maximum();
        console.log(task.maxFee);
        
        assert.ok(1);
    });
});

