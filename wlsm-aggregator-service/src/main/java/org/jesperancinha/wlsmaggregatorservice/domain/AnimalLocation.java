package org.jesperancinha.wlsmaggregatorservice.domain;

import java.util.UUID;

public record AnimalLocation(
        UUID id,
        String animalId,
        Long latitude,
        Long longitude
) {
}
