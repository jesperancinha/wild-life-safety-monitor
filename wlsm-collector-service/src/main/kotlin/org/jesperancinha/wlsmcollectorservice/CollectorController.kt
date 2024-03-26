package org.jesperancinha.wlsmcollectorservice

import org.springframework.http.ResponseEntity
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
    suspend fun listenAnimalLocation(@RequestBody animalLocation: AnimalLocation): ResponseEntity<Unit> = run {
         collectorService.persist(animalLocation)
        ResponseEntity.ok().build()
    }
}