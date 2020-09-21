var express = require('express');
var app = express();

var path = require('path');
var fs = require('fs');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
//setup public folder
app.use(express.static('./public'));

var bodyParser = require('body-parser');
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());

//our tiny alert message midleware
function messages(req,res,next){
    var message;
    res.locals.message = message;
    next();
}


/* app.get('/', function (req, res) {
    var currentdatetime = (new Date()).toTimeString();
    var message = `Connected to the server at ${currentdatetime}`;
    res.send(message);
}) */

app.get('/',function (req, res) {
    res.render('pages/home')
});

app.get('/logo', function (req, res) {
    var logofile = `${__dirname}\\public\\images\\logo1.png`;
    res.sendFile(logofile);
})

app.get('/users', function (req, res) {
    var familyfile = `${__dirname}\\public\\family.html`;
    res.sendFile(familyfile);
})

app.get('/links',function (req, res) {
    //array with items to send
    var items = [
        {name:'node.js',url:'https://nodejs.org/en/'},
        {name:'ejs',url:'https://ejs.co'},
        {name:'expressjs',url:'https://expressjs.com'},
        {name:'IBM SDK for Node.js',url:'https://developer.ibm.com/node/sdk/'},
        // {name:'vuejs',url:'https://vuejs.org'},
        // {name:'nextjs',url:'https://nextjs.org'}
    ];
    res.render('pages/links',{
        links:items
    })
});

app.get('/references',function (req, res) {
    //array with items to send
    var items = [
        {name:'Mainframe Modernization-List of Candidate Components and Tools',url:'https://finastra.sharepoint.com/:w:/r/Structured/CSLPTransitionIn/Shared%20Documents/Architecture/Architecture%20Team/Legacy%20Systems/MF%20-%20Modernization%20Roadmap%20-%20List%20of%20Candidate%20Components%20and%20Tools.rtf?d=wfc42067228b94abba124069aef0d07be&csf=1&web=1'},
        {name:'SL-Configuration and Operations Monitoring Portal v1',url:'https://finastra.sharepoint.com/:w:/r/Structured/CSLPTransitionIn/Shared%20Documents/Architecture/Architecture%20Team/Administration%20Portals/SL-Configuration%20and%20Operations%20Monitoring%20Portal%20v1.docx?d=w6d7bcbc5188148f8ba09e23d415e165f&csf=1&web=1'},
    ];
    res.render('pages/references',{
        references:items
    })
});

app.get('/list',function (req, res) {
    //array with items to send
    var items = ['node.js','expressjs','ejs','javascript','bootstarp'];
    res.render('pages/list',{
        list:items
    })
});

app.get('/table',function (req, res) {
    //array with items to send
    var items = [
        {name:'node.js',url:'https://nodejs.org/en/'},
        {name:'ejs',url:'https://ejs.co'},
        {name:'expressjs',url:'https://expressjs.com'},
        {name:'vuejs',url:'https://vuejs.org'},
        {name:'nextjs',url:'https://nextjs.org'}];
    res.render('pages/table',{
        table:items
    })
});

app.get('/deltahooks',function (req, res) {
    
    //array with items to send
    var records = [
        {borrowerid:'123435',field:'phonenumber',fromvalue:'905-847-8709',tovalue:'289-342-1234',changedate:'08/23/2020',changetime:'13:23:03.123'},
        {borrowerid:'123435',field:'phonenumber',fromvalue:'905-847-8709',tovalue:'289-342-1234',changedate:'08/23/2020',changetime:'13:23:03.123'},
        {borrowerid:'123435',field:'phonenumber',fromvalue:'905-847-8709',tovalue:'289-342-1234',changedate:'08/23/2020',changetime:'13:23:03.123'},
        {borrowerid:'123435',field:'phonenumber',fromvalue:'905-847-8709',tovalue:'289-342-1234',changedate:'08/23/2020',changetime:'13:23:03.123'},
        {borrowerid:'123435',field:'phonenumber',fromvalue:'905-847-8709',tovalue:'289-342-1234',changedate:'08/23/2020',changetime:'13:23:03.123'}
    ];
    res.render('pages/deltahooks',{
        dataset:records
    })
});

/* app.get('/logs',function (req, res) {
    var loglist = []
    
    logfilename = 'LOG_sample1.txt'
    logfilepath = `${__dirname}\\data\\${logfilename}`
    var readStream = fs.createReadStream(logfilepath, 'utf8');
    let data = ''
    readStream.on('data', function(chunk) {
        data += chunk;
    }).on('end', function() {
        // console.log(data);

        rows = data.split('\r\n')
        rows.forEach((row) => {
            fields = row.split('|')
            logdate = fields[1].split('-')[0].split('/')[0]
            year = logdate.substring(0,4)
            month = logdate.substring(4,6)
            day = logdate.substring(6,8)
            logtime = fields[1].split('-')[0].split('/')[1]
            hour = logtime.substring(0,2)
            min = logtime.substring(2,4)
            sec = logtime.substring(4,6) 
            cent = logtime.substring(6,8)
            log = {
                datetime:new Date(`${year}/${month}/${day} ${hour}:${min}:${sec}:${cent}`).toUTCString(),
                origin:fields[1].split('-')[1] == 'B' ? 'Batch' : 'Online',
                program:fields[1].split('-')[2],
                sin:fields[2],
                action:fields[3],
                field:fields[4].split('=')[0],
                value:fields[4].split('=')[1]
            }
            loglist.push(log)
            console.log(log)
        })
    }).on('end',() => {
        console.log(loglist);
        sortlogs = loglist.sort(function(x,y){return x.datetime - y.datetime});
        res.render('pages/logs',{
            logs:sortlogs
        })
    });
    
}); */

app.get('/form',messages,function (req, res) {
    res.render('pages/form');
});

app.post('/form',function (req, res) {
    var message=req.body;
    res.locals.message = message;
    res.render('pages/form');
});

app.get('/logspersin',messages,function (req, res) {
    res.render('pages/logs',{sin:undefined,logs:undefined,err:undefined});
});

app.post('/logspersin',function (req, res) {
    var loglist = []
    
    var sinno=req.body.sinno;

    logfilename = 'LOG_sample1.txt'
    logfilepath = `${__dirname}\\data\\${logfilename}`
    var readStream = fs.createReadStream(logfilepath, 'utf8');
    let data = ''
    readStream.on('data', function(chunk) {
        data += chunk;
    }).on('end', function() {
        // console.log(data);

        rows = data.split('\r\n')
        rows.forEach((row) => {
            fields = row.split('|')
            logdate = fields[1].split('-')[0].split('/')[0]
            year = logdate.substring(0,4)
            month = logdate.substring(4,6)
            day = logdate.substring(6,8)
            logtime = fields[1].split('-')[0].split('/')[1]
            hour = logtime.substring(0,2)
            min = logtime.substring(2,4)
            sec = logtime.substring(4,6) 
            cent = logtime.substring(6,8)
            log = {
                datetime:new Date(`${year}/${month}/${day} ${hour}:${min}:${sec}:${cent}`).toUTCString(),
                origin:fields[1].split('-')[1] == 'B' ? 'Batch' : 'Online',
                program:fields[1].split('-')[2],
                sin:fields[2],
                action:fields[3],
                field:fields[4].split('=')[0],
                value:fields[4].split('=')[1]
            }
            loglist.push(log)
            console.log(log)
        })
    }).on('end',() => {
        console.log(loglist);
        
        reslogs = undefined
        errmsg = undefined
        
        sinlogs = []
        if (sinno == 'ALL'){
            sinlogs = loglist;
            reslogs = sinlogs.sort(function(x,y){return x.datetime - y.datetime}); 
        }
        else 
        {
            if (!isNaN(sinno))
            {     
                // sinno is NUMBER
                loglist.forEach(x => {
                    if (x.sin == sinno){
                        sinlogs.push(x)
                    }
                });
                if (sinlogs.length == 0)
                {
                    // there are NO RECORDS under that sinno
                    errmsg = 'SIN# you entered is not captured in the log files!';
                }
                else {
                    // there are RECORDS under that sinno
                    reslogs = sinlogs.sort(function(x,y){return x.datetime - y.datetime}); 
                }
            }
            else
            {
                // sinno is NOT NUMBER
                errmsg = 'SIN# you entered in not valid!';
            }
        }
        
        res.render('pages/logs',{
            sin:sinno,logs:reslogs,err:errmsg
        })
    });
});

var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port

   console.log("Server listening at http://%s:%s (address family %s)", host, port, server.address().family)
})