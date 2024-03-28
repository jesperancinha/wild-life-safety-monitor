package org.jesperancinha.listener;

import java.util.UUID;

public record AnimalLocationDto(
        String animalId,
        Long latitude,
        Long longitude
) {
}
