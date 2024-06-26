package org.jesperancinha.listener;


import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping
public class ListenerController {
    private final ListenerService listenerService;

    ListenerController(ListenerService listenerService) {
        this.listenerService = listenerService;
    }

    @GetMapping("info")
    public String info() {
        return "Listener Service V1";
    }

    @PostMapping("create")
    public Mono<AnimalLocationDto> sendAnimalLocation(
            @RequestBody AnimalLocationDto animalLocationDto) {
        return listenerService.persist(animalLocationDto);
    }
}
