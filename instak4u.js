var fs = require('fs'),
    http = require('http');

http.createServer(function (req, res) {
    let path = req.url.toString();
    const pathWithoutParams = path.split('?').length > 1 ? path.split('?')[0] : '';
    if (path === '/' || pathWithoutParams.endsWith('/feed') || pathWithoutParams.endsWith('/event/details')) {
        path = '/index.html';
    }
    console.log(path);
  fs.readFile(__dirname + '/build/web' + path, function (err,data) {
    if (err) {
      res.writeHead(404);
      res.end(JSON.stringify(err));
      return;
    }
    res.writeHead(200);
    res.end(data);
  });
}).listen(8080);