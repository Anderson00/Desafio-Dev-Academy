CREATE TABLE User (
    id      INTEGER PRIMARY KEY,
    nome    TEXT,
    email   TEXT
);

CREATE TABLE Nota (
    id       TEXT    PRIMARY KEY,
    nome     TEXT,
    calorias INTEGER,
    preco    DOUBLE,
    user_id number(2) REFERENCES User(id),
);
