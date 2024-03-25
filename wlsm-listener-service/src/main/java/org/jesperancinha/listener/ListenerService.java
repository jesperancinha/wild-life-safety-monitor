package org.jesperancinha.listener;

import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ListenerService {
    HazelcastInstance hazelcastInstance = Hazelcast.newHazelcastInstance();
    List<AnimalLocation> cache = hazelcastInstance.getList("data");


    public AnimalLocation persist(AnimalLocation animalLocation) {
        cache.add(animalLocation);
        return animalLocation;
    }
}
