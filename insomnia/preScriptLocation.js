const baseUrl = insomnia.environment.get('base_url');
console.log('Base URL:', baseUrl);
console.log('Oh nanana!', 'Love me');

const data = {
    "animalId": "d9b9e46d-c050-4191-8b42-fea3d849d49c",
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
