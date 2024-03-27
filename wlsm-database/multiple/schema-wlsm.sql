CREATE TABLE animal_location (
    id uuid DEFAULT gen_random_uuid(),
    animal_id uuid,
    latitude BIGINT,
    longitude BIGINT,
    PRIMARY KEY(id),
    CONSTRAINT fk_animal
        FOREIGN KEY(animal_id)
            REFERENCES animal(id)
)

CREATE TABLE animal (
    id uuid DEFAULT gen_random_uuid(),
    name VARCHAR(100),
    species_id uuid,
    PRIMARY KEY(id),
    CONSTRAINT fk_species
        FOREIGN KEY(species_id)
            REFERENCES species(id)
)

CREATE TABLE species(
    id uuid DEFAULT gen_random_uuid(),
    common_name VARCHAR(100),
    family uuid,
    genus uuid
)