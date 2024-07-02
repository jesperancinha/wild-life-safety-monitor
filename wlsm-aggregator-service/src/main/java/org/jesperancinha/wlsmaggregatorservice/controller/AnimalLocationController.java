package org.jesperancinha.wlsmaggregatorservice.controller;

import org.jesperancinha.wlsmaggregatorservice.dto.AnimalLocationDto;
import org.jesperancinha.wlsmaggregatorservice.service.AnimalLocationService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("location")
public class AnimalLocationController {
    private final AnimalLocationService animalLocationService;

    private AnimalLocationController(AnimalLocationService animalLocationService) {
        this.animalLocationService = animalLocationService;
    }

    @GetMapping
    public Flux<AnimalLocationDto> listAll() {
        return animalLocationService.findAll();
    }
}
