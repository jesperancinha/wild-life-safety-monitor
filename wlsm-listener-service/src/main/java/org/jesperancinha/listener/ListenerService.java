package org.jesperancinha.listener;

import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;


@Service
public class ListenerService {

    @Value("${wslm.url.collector:http://localhost:8080}")
    private String collectorUrl;

    private final WebClient client = WebClient.create(collectorUrl);

    HazelcastInstance hazelcastInstance = Hazelcast.newHazelcastInstance();
    List<AnimalLocation> cache = hazelcastInstance.getList("data");


    public Mono<AnimalLocation> persist(AnimalLocation animalLocation) {
        cache.add(animalLocation);

        return client.post()
                .uri(collectorUrl.concat("/animals"))
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(animalLocation)
                .retrieve()
                .bodyToMono(AnimalLocation.class);
    }
}
