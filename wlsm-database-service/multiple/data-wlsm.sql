INSERT INTO genuses(name)
VALUES ('Phoebastria');

INSERT INTO families(name)
VALUES ('Diomedeidae');

INSERT INTO species(common_name, family, genus)
VALUES ('Albatross', (SELECT id FROM families LIMIT 1), (SELECT id FROM genuses LIMIT 1));

INSERT INTO animal(name, species_id)
VALUES ('Piquinho', (SELECT id from species LIMIT 1));

INSERT INTO animal(id, name, species_id)
VALUES ('52073642-392c-11ef-b6c4-0bae65032803', 'Test Piquinho', (SELECT id from species LIMIT 1));
