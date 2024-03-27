package org.jesperancinha.wlsmcollectorservice.service

import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocationDto
import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocationEvent
import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service

@Service
class CollectorService(
    val applicationEventPublisher: ApplicationEventPublisher
) {
    fun persist(animalLocationDto: AnimalLocationDto) =
        applicationEventPublisher.publishEvent(AnimalLocationEvent(animalLocationDto))

}