const {Message} = require('./messenger_pb.js');
const {MessengerClient} = require('./messenger_grpc_web_pb.js');

const client = new MessengerClient("http://localhost:8080", null, null);
// const client = new MessengerClient("http://localhost:8000", null, null);

const request = new Message();
request.setText('Hello there!');
request.setAuthor('Joao');

client.send(request, {}, (err, response) => {
    alert(JSON.stringify(request.array));
    alert(JSON.stringify(response.getResult()));
    console.log(response.getResult());

    request.setText('Hello there!');
    request.setAuthor('blocked');

    client.send(request, {}, (err, response) => {
        alert(JSON.stringify(request.array));
        alert(JSON.stringify(response.getResult()));
        console.log(response.getResult());
    });
})
