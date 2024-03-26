package org.jesperancinha.wlsmcollectorservice


data class AnimalLocation(
    val name: String,
    val latitude: Long,
    val longitude: Long
)

data class AnimalLocationEvent (
    val animalLocation: AnimalLocation
)