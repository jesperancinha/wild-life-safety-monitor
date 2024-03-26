package org.jesperancinha.wlsmcollectorservice

import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service

@Service
class CollectorService(
    val applicationEventPublisher: ApplicationEventPublisher
) {
    fun persist(animalLocation: AnimalLocation) =
        applicationEventPublisher.publishEvent(AnimalLocationEvent(animalLocation))

}