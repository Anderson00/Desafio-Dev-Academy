#ifndef NOTA_H
#define NOTA_H

#include <QString>

class Nota
{
public:
    Nota();
    Nota(int& id, QString& titulo, QString& desc, QString cor, QString& data);

    int id;
    QString titulo;
    QString desc;
    QString cor;
    QString data;

};

#endif // NOTA_H
