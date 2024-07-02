package org.jesperancinha.wlsmaggregatorservice.controller;

import org.jesperancinha.wlsmaggregatorservice.dto.AnimalDto;
import org.jesperancinha.wlsmaggregatorservice.service.AnimalService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("animal")
public class AnimalController {

    private final AnimalService animalService;

    public AnimalController(AnimalService animalService){

        this.animalService = animalService;
    }

    @GetMapping
    public Flux<AnimalDto> getAnimals() {
        return animalService.findAllAnimals();
    }
}
