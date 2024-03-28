package org.jesperancinha.listener;

import com.hazelcast.config.Config;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.nio.serialization.DataSerializableFactory;
import com.hazelcast.nio.serialization.IdentifiedDataSerializable;
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
    List<AnimalLocationDto> cache = hazelcastInstance.getList("data");

    public Mono<AnimalLocationDto> persist(AnimalLocationDto animalLocationDto) {
        cache.add(animalLocationDto);

        return client.post()
                .uri(collectorUrl.concat("/animals"))
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(animalLocationDto)
                .retrieve()
                .bodyToMono(AnimalLocationDto.class);
    }
}
