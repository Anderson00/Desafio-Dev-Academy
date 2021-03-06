#include "nota.h"

Nota::Nota()
{

}

Nota::Nota(int &id, QString &titulo, QString &desc, QString cor, QString &data)
    :   id(id), titulo(titulo), desc(desc), cor(cor), data(data)
{

}
