package org.jesperancinha.listener;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping
public class ListenerController {
    private final ListenerService listenerService;

    ListenerController(ListenerService listenerService){

        this.listenerService = listenerService;
    }
    @GetMapping("info")
    public String info() {
        return "Listener Service V1";
    }

    @PostMapping("create")
    public ResponseEntity<AnimalLocation> sendAnimalLocation(
            @RequestBody AnimalLocation animalLocation){
        return ResponseEntity.ofNullable(listenerService.persist(animalLocation));
    }
}
