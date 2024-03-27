package org.jesperancinha.listener;

import java.util.UUID;

public record AnimalLocation(
        UUID id,
        Long latitude,
        Long longitude
) {
}
