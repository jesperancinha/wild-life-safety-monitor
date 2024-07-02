package org.jesperancinha.wlsmaggregatorservice.domain;

import org.jesperancinha.wlsmaggregatorservice.dto.AnimalLocationDto;

public class AnimalLocationConverter {
    public static AnimalLocationDto toDto(AnimalLocation animalLocation) {
        return new AnimalLocationDto(
                animalLocation.animalId(),
                animalLocation.latitude(),
                animalLocation.longitude()
        );
    }
}
