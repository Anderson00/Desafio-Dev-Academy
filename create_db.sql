CREATE TABLE User (
    id          INTEGER PRIMARY KEY,
    username    TEXT,
    nome        TEXT,
    email       TEXT
);

CREATE TABLE Nota (
    id      INTEGER    PRIMARY KEY,
    titulo  TEXT,
    desc    TEXT,
    cor     TEXT,
    data    TEXT,
    user_id REFERENCES User(id)
);

CREATE TABLE Marcador (
    id      INTEGER PRIMARY KEY,
    nome   TEXT
);

CREATE TABLE Nota_Marcador(
    nota_id         REFERENCES Nota(id),
    marcador_id     REFERENCES Marcador(id)
);


INSERT INTO User(username, nome, email) VALUES("Dev","Dev Academy", "dev.academy@dev.com");
INSERT INTO Nota(titulo, desc, cor, data, user_id) VALUES("test", "Nota de test", "yellow", "03/03/21", 1);
