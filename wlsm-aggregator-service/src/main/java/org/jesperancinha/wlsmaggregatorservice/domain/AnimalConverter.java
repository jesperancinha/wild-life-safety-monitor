package org.jesperancinha.wlsmaggregatorservice.domain;

import org.jesperancinha.wlsmaggregatorservice.dto.AnimalDto;

public class AnimalConverter {
    public static AnimalDto toDto(Animal animal) {
        return new AnimalDto(
                animal.id().toString(),
                animal.name(),
                animal.speciesId().toString()
        );
    }
}
