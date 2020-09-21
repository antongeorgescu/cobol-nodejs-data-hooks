// https://nodejs.org/en/docs/guides/timers-in-node/

function myFunc(arg) {
    console.log(`arg was => ${arg}`);
}

setTimeout(myFunc, 1500, 'funky');

var fs = require('fs');
var path = require('path');

function readfile(){
    
    var readStream = fs.createReadStream(path.join(__dirname, './data') + '/myfamily.txt', 'utf8');
    let data = ''
    readStream.on('data', function(chunk) {
        data += chunk;
    }).on('end', function() {
        console.log(data);
    });
}

function intervalFunc() {
    console.log('Read text file...');
    readfile()
}

setInterval(intervalFunc, 5000);

