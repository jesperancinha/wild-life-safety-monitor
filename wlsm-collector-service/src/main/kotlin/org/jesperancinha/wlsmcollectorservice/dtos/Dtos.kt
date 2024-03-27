package org.jesperancinha.wlsmcollectorservice.dtos

import java.util.*
data class AnimalLocationDto(
    val animalId: UUID,
    val latitude: Long,
    val longitude: Long
)

data class AnimalLocationEvent (
    val animalLocationDto: AnimalLocationDto
)