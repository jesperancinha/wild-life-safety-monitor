package org.jesperancinha.wlsmaggregatorservice.dto;

import java.util.UUID;

public record AnimalDto(
        String id,
        String name,
        String speciesId
) {

}
