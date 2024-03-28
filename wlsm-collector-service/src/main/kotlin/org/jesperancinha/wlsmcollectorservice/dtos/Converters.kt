package org.jesperancinha.wlsmcollectorservice.dtos

import org.springframework.data.annotation.Id
import org.springframework.data.relational.core.mapping.Table
import java.util.*

@Table
data class AnimalLocation(
    @Id
    val id: UUID? = null,
    val animalId: UUID,
    val latitude: Long,
    val longitude: Long
)

fun AnimalLocationDto.toEntity() = AnimalLocation(
    animalId = animalId,
    latitude = latitude,
    longitude = longitude
)