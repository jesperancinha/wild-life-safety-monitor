package org.jesperancinha.wlsmcollectorservice.domain

import org.jesperancinha.wlsmcollectorservice.dtos.AnimalLocationDto
import java.util.UUID
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

interface AnimalLocationDao : ReactiveCrudRepository<AnimalLocationDto, UUID>