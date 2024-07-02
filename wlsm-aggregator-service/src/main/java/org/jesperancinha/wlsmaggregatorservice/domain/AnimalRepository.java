package org.jesperancinha.wlsmaggregatorservice.domain;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;

import java.util.UUID;

public interface AnimalRepository extends ReactiveCrudRepository<Animal, UUID> {
}
