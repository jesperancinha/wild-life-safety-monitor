const {Message} = require('./messenger_pb.js');
const {MessengerClient} = require('./messenger_grpc_web_pb.js');

const client = new MessengerClient("http://localhost:50051", null, null);

const request = new Message();
request.setText('Hello there!');
request.setAuthor('Joao');

client.send(request, {}, (err, response) => {
    console.log(response);
});