var http = require("http");

var url = require('url');

http.createServer(function (req, res) {
res.writeHead(200, {'Content-Type': 'text/plain'});

var urlParts = url.parse(req.url);

switch(urlParts.pathname) {
        case "/":
            homepage(req, res);
            break;
        case "/read":
            read(req, res);
            break;
        case "/svc/update":
            update(req, res);
            break;
        default:
            homepage(req,res);
            break;
    }
res.end('Hello World\n');
}).listen(8082);

//functions to process incoming requests
function homepage(req, res) {
    res.end("Hello, this is the home page :   ) : " + req.connection.remoteAddress); 
}
 
function read(req, res) {
    res.end("Hello, there is no data for reading yet.");    
}
 
function update(req, res) {
    res.end("Hello, there is no data for update");    
}
 

console.log('Server running at http://127.0.0.1:8082/');
