package org.jesperancinha.wlsmaggregatorservice.dto;

public record AnimalLocationDto(
        String animalId,
        Long latitude,
        Long longitude
) {
}
