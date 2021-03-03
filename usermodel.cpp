#include "usermodel.h"
#include <QDebug>
#include <QSqlQuery>

UserModel::UserModel(QObject *parent, Database *database) : m_database(database)
{
    QSqlQuery query(m_database->database());
    query.prepare("SELECT * FROM User");
    if(query.exec() && query.first()) {
        m_user = query.value("username").toString();
        m_id = query.value("id").toString();
        m_nome = query.value("nome").toString();
        m_email = query.value("email").toString();
    }
}


QString UserModel::username()
{
    return m_user;
}

QString UserModel::nome()
{
    return m_nome;
}

QString UserModel::email()
{
    return m_email;
}

QString UserModel::id()
{
    return m_id;
}


void UserModel::setUsername(QString id,QString user)
{
    if(m_user != user) {
        QSqlQuery query(m_database->database());
        query.prepare("UPDATE User SET username = :user WHERE id = :id");
        query.bindValue(":id", id);
        query.bindValue(":user", user);

        if (query.exec()) {
            m_user = user;
            emit usernameChanged(m_user);
        }
    }
}

void UserModel::setNome(QString id, QString nome)
{
    if(m_nome != nome) {
        QSqlQuery query(m_database->database());
        query.prepare("UPDATE User SET nome = :nome WHERE id = :id");
        query.bindValue(":id", id);
        query.bindValue(":nome", nome);

        if (query.exec()) {
            m_nome = nome;
            emit nomeChanged(m_nome);
        }
    }
}

void UserModel::setEmail(QString id, QString email)
{
    if(m_email != email) {
        QSqlQuery query(m_database->database());
        query.prepare("UPDATE User SET email = :email WHERE id = :id");
        query.bindValue(":id", id);
        query.bindValue(":email", email);

        if (query.exec()) {
            m_email = email;
            emit emailChanged(m_email);
        }
    }
}
