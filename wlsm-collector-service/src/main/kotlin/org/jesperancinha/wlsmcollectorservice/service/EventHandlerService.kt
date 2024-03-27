package org.jesperancinha.wlsmcollectorservice.service

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
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
        runBlocking(Dispatchers.IO) {
            animalLocationDao.save(animalLocationEvent.animalLocationDto.toEntity())
        }
    }
}