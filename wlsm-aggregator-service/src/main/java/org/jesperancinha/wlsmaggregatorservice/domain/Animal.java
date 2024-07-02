package org.jesperancinha.wlsmaggregatorservice.domain;

import java.util.UUID;

public record Animal(
        UUID id,
        String name,
        UUID speciesId
) {

}
