var fs = require('fs'), http = require('https');

if (!process.env.TL1_KEY) {
  throw Error('TL1_KEY must be defined');
}

if (!process.env.TL1_CERT) {
  throw Error('TL1_CERT must be defined');
}

const options = {
  key: fs.readFileSync(process.env.TL1_KEY),
  cert: fs.readFileSync(process.env.TL1_CERT)
};

http.createServer(options, function (req, res) {
    let path = req.url.toString();
    const pathWithoutParams = path.split('?').length > 1 ? path.split('?')[0] : '';
    if (path === '/' || path === '/sign/up' || path === '/sign/in' || pathWithoutParams.endsWith('/feed') || pathWithoutParams.endsWith('/event/details')) {
        path = '/index.html';
    } else {
      path = pathWithoutParams || path;
    }
    console.log(path);
  fs.readFile(__dirname + '/build/web' + path, function (err,data) {
    if (err) {
      console.log(`${__dirname + '/build/web' + path} not found`);
      res.writeHead(404);
      res.end(JSON.stringify(err));
      return;
    }
    let headers = {};
    if (pathWithoutParams.endsWith('flutter_service_worker.js')) {
      headers = {'content-type': 'application/javascript'};
    }
    res.writeHead(200, headers);
    res.end(data);
  });
}).listen(8080);