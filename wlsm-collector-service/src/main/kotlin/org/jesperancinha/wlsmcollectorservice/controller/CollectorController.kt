package org.jesperancinha.wlsmcollectorservice.controller

import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocationDto
import org.jesperancinha.wlsmcollectorservice.service.CollectorService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping
class CollectorController(
    val collectorService: CollectorService
) {

    @PostMapping("animals")
    suspend fun listenAnimalLocation(@RequestBody animalLocationDto: AnimalLocationDto): AnimalLocationDto = run {
        collectorService.persist(animalLocationDto)
        animalLocationDto
    }
}