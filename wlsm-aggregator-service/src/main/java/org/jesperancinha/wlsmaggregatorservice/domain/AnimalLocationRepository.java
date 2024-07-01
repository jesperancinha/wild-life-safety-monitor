package org.jesperancinha.wlsmaggregatorservice.domain;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;

import java.util.UUID;

public interface AnimalLocationRepository extends ReactiveCrudRepository<AnimalLocation, UUID> {
}
