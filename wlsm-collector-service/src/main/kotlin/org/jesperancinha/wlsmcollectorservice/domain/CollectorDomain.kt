package org.jesperancinha.wlsmcollectorservice.domain

import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocation
import org.springframework.data.repository.kotlin.CoroutineCrudRepository
import java.util.*

interface AnimalLocationDao : CoroutineCrudRepository<AnimalLocation, UUID>