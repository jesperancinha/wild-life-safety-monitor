package org.jesperancinha.wlsmaggregatorservice.service;

import org.jesperancinha.wlsmaggregatorservice.domain.AnimalConverter;
import org.jesperancinha.wlsmaggregatorservice.domain.AnimalRepository;
import org.jesperancinha.wlsmaggregatorservice.dto.AnimalDto;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

@Service
public class AnimalService {

    private final AnimalRepository animalRepository;

    public AnimalService(AnimalRepository animalRepository){
        this.animalRepository = animalRepository;
    }

    public Flux<AnimalDto> findAllAnimals() {
        return animalRepository.findAll().map(AnimalConverter::toDto);
    }
}
