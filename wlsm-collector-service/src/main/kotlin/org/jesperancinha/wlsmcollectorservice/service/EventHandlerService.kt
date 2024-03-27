package org.jesperancinha.wlsmcollectorservice.service

import org.jesperancinha.wlsmcollectorservice.domain.AnimalLocationDao
import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocationEvent
import org.jesperancinha.wlsmcollectorservice.dtos.toEntity
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Service


@Service
class EventHandlerService(
   val animalLocationDao: AnimalLocationDao
) {
    @EventListener
    fun processEvent(animalLocationEvent: AnimalLocationEvent){
        println(animalLocationEvent)
        animalLocationDao.save(animalLocationEvent.animalLocationDto.toEntity())
    }
}