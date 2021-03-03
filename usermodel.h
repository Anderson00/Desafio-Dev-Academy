#ifndef USERMODEL_H
#define USERMODEL_H
#include <QObject>
#include "database.h"

class UserModel : public QObject
{
    Q_OBJECT
public:
    explicit UserModel(QObject *parent = nullptr, Database *database = new Database());

    Q_PROPERTY(QString username READ username NOTIFY usernameChanged)
    Q_PROPERTY(QString id READ id)
    Q_PROPERTY(QString nome READ nome NOTIFY nomeChanged)
    Q_PROPERTY(QString email READ email NOTIFY emailChanged)

    QString username();
    QString nome();
    QString email();
    QString id();
    Q_INVOKABLE void setUsername(QString id, QString user);
    Q_INVOKABLE void setNome(QString id, QString nome);
    Q_INVOKABLE void setEmail(QString id, QString email);

signals:
    void usernameChanged(QString user);
    void nomeChanged(QString nome);
    void emailChanged(QString email);

private:
    QString m_user;
    QString m_nome;
    QString m_email;
    QString m_id;
    Database *m_database;
};

#endif // USERMODEL_H
