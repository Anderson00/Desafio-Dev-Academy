#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "model.h"

class Controller : public QObject
{
Q_OBJECT

public:
    explicit Controller(QObject *parent = nullptr);
    void setModel(Model *model);
    Q_INVOKABLE void mudarNome(QString nome);
private:
    Model *m_model;
};

#endif // CONTROLLER_H
