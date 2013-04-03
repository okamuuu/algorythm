function Task() {
    // タスク
    this.tasks = [
        {fee:130, day: 9},
        {fee:150, day:12},
        {fee:190, day:20},
        {fee:190, day:23},
        {fee:230, day:27},
        {fee:290, day:33},
        {fee:330, day:31},
        {fee: 70, day: 9},
        {fee:330, day:30},
        {fee:110, day: 9},
        {fee:90,  day: 6},
        {fee:310, day:34},
        {fee:330, day:34},
        {fee:190, day:22},
        {fee:230, day:25},
        {fee:170, day:13}
    ]
    this.sorted = false;
    this.limits = {
        count: 5000,    // 「タスクの組み合わせ」は、最大5000通り
        day: 100        // 100日以内で最も高いfeeを計算する
    }

    this.maxFee = 0;
    this.counter = 0;
}

// 期間内で最も高いfeeを計算する
Task.prototype.maximum = function() {
    // 短時間で最も高いfeeを算出するために並び替える
    this.sort();
    // 最も高いfeeを算出（繰り返しの回数に注意）
    this.calc();
};

// 比較はこのメソッドを利用して行ってください
Task.prototype.compare = function(fee, day) {
    this.counter++;
    if (day < this.limits.day && this.maxFee < fee) {
        this.maxFee = fee;
        console.log(this.counter, fee);
    }
}

Task.prototype.sort = function() {
    // 平均単価の高い順に並び替える
    this.tasks.sort(function(a,b){
        if(a.fee / a.day < b.fee / b.day) {
            return 1;
        }
        else {
            return -1;
        }
    });
    this.sorted = true;
}

Task.prototype.calc = function() {

    var length = this.tasks.length;
    
    var patterns = [];
    patterns[0] = [0];
    
    for (var i=1; i < length+1; i++) {
    
        patterns[i] = clone(patterns[i-1]);
        
        var task = this.tasks.shift();
        
        for (var j=0; j < this.limits.day; j++) { 
            
            if ( typeof patterns[i-1][j] == 'number' ) {

                var _fee = patterns[i-1][j] + task.fee;
                var _day = j + task.day;
        
                if ( _day <= this.limits.day ) {
                    if ( patterns[i][_day] ) {
                        patterns[i][_day] = _fee > patterns[i][_day] ? _fee : patterns[i][_day];
                    }
                    else {
                        patterns[i][_day] = _fee;
                    }
                }
            }
        }
    }
  
    var lastPatterns = patterns.pop();

    for ( var i = 0, length = lastPatterns.length; i < length; i++ ) {
        this.compare(lastPatterns[i], i); 
    }
}

function clone(x)
{
    if (x === null || x === undefined)
        return x;
    if (x.clone)
        return x.clone();
    if (x.constructor == Array)
    {
        var r = [];
        for (var i=0,n=x.length; i<n; i++)
            r.push(clone(x[i]));
        return r;
    }
    return x;
}

module.exports = Task;
