package org.jesperancinha.listener;

import java.util.UUID;

public record AnimalLocation(
        UUID animalId,
        Long latitude,
        Long longitude
) {
}
