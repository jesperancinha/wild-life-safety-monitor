const baseUrl = insomnia.environment.get('base_url');
console.log('Base URL:', baseUrl);

const rawReq1 = {
    url: "http://localhost:8082/api/v1/aggregator/animal",
    method: 'GET',
    headers: {
        'Content-Type': 'application/json',
    }
};

const response1 = await new Promise((resolve, reject) => {
    insomnia.sendRequest(
        rawReq1,
        (err, resp) => {
            if (err != null) {
                reject(err);
            } else {
                resolve(resp);
            }
        }
    );
});

const data = {
    "animalId": String(JSON.parse(response1.body)[0].id),
    "latitude": 52505252,
    "longitude": 28639152
}


const rawReq = {
    url: 'http://localhost:8080/app/v1/listener/create',
    method: 'POST',
    header: {
        'Content-Type': 'application/json',
    },
    body: {
        mode: 'raw',
        raw: JSON.stringify(data)
    }
};

const resp = await new Promise((resolve, reject) => {
    insomnia.sendRequest(
        rawReq,
        (err, resp) => {
            if (err != null) {
                reject(err);
            } else {
                resolve(resp);
            }
        }
    );
});
