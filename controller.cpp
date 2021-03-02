#include "controller.h"
#include <QDebug>

Controller::Controller(QObject *parent)
{

}

void Controller::setModel(Model *model)
{
    m_model = model;
}

void Controller::mudarNome(QString nome)
{
    qDebug() << "Mudar Nome (controller)" << nome;
//    m_model->setName(nome);
}
