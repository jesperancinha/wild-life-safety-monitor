package org.jesperancinha.wlsmcollectorservice

import org.springframework.context.event.EventListener
import org.springframework.stereotype.Service


@Service
class EventHandlerService {
    @EventListener
    fun processEvent(animalLocationEvent: AnimalLocationEvent){
        println(animalLocationEvent)
    }
}