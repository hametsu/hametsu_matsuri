// リアルタイム通信のためのサーバー
// メッセージを全クライアントにブロードキャストする
//
var http = require('http');
var io = require('socket.io');

server = http.createServer(function(req, res){
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('<h1>sample server</h1>');
    res.end();
});
server.listen(4545);

var socket = io.listen(server);
socket.on('connection', function(client){
    client.on('message', function(message) {
      client.send(message);
      client.broadcast(message);
      console.log(message);
    });

    client.on('disconnect', function(){
         console.log('connection closed');
    });
});
