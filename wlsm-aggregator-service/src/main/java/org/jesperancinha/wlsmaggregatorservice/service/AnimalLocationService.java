package org.jesperancinha.wlsmaggregatorservice.service;

import org.jesperancinha.wlsmaggregatorservice.domain.AnimalConverter;
import org.jesperancinha.wlsmaggregatorservice.domain.AnimalLocationRepository;
import org.jesperancinha.wlsmaggregatorservice.dto.AnimalLocationDto;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

@Service
public class AnimalLocationService {
    private final AnimalLocationRepository animalLocationRepository;

    public AnimalLocationService(AnimalLocationRepository animalLocationRepository){
        this.animalLocationRepository = animalLocationRepository;
    }

    public Flux<AnimalLocationDto> findAll() {
        return animalLocationRepository.findAll().map(AnimalConverter::toDto);
    }
}
