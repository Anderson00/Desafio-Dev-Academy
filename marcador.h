#ifndef MARCADOR_H
#define MARCADOR_H

#include <QObject>

class Marcador : public QObject
{
    Q_OBJECT
public:
    explicit Marcador(QObject *parent = nullptr);

signals:

};

#endif // MARCADOR_H
