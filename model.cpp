#include "model.h"
#include <QDebug>
#include <QSqlQuery>

Model::Model(QObject *parent, Database *database) : m_database(database)
{

}

QString Model::name()
{
    if(m_name == "" || m_name.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM dev_academy");
        if(query.exec() && query.first()) {
            m_name = query.value("nome").toString();
        }
    }
    return m_name;
}

QString Model::id()
{
    if(m_id == "" || m_id.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM dev_academy");
        if(query.exec() && query.first()) {
            m_id = query.value("id").toString();
        }
    }
    return m_id;
}

void Model::setName(QString name, QString id)
{
    if(m_name != name) {
        QSqlQuery query(m_database->database());
        query.prepare("UPDATE dev_academy SET nome = :name WHERE id = :id");
        qDebug() << name << id;
        query.bindValue(":id", id);
        query.bindValue(":name", name);

        if (query.exec()) {
            m_name = name;
            emit nameChanged(m_name);
        }
    }
}
