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
    date    TEXT,
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
INSERT INTO Nota(titulo, desc, cor, date, user_id) VALUES("test", "Nota de test", "yellow", "03/03/2021 00:30", 1);
INSERT INTO Nota(titulo, desc, cor, date, user_id) VALUES("test2", "Nota de test, Nota de test, Nota de test.", "#1ac4bc", "03/03/2021 01:33", 1);
