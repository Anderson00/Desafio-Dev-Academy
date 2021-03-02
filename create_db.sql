CREATE TABLE fruta (
    id       TEXT    PRIMARY KEY,
    nome     TEXT,
    calorias INTEGER,
    preco    DOUBLE
);

CREATE TABLE dev_academy (
    id    TEXT PRIMARY KEY,
    nome  TEXT,
    senha TEXT
);

INSERT INTO fruta(id, nome, calorias, preco) VALUES ('1', 'abacaxi', 320, 4.20);
INSERT INTO fruta(id, nome, calorias, preco) VALUES ('2', 'morango', 514, 1.20);
INSERT INTO fruta(id, nome, calorias, preco) VALUES ('3', 'kiwi', 114, 4.12);
INSERT INTO fruta(id, nome, calorias, preco) VALUES ('4', 'banana', 32, 8.61);
INSERT INTO fruta(id, nome, calorias, preco) VALUES ('5', 'maçã', 49, 2.21);
INSERT INTO fruta(id, nome, calorias, preco) VALUES ('6', 'pera', 232, 1.25);
