#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include "database.h"

class Model : public QObject
{
Q_OBJECT
public:
    explicit Model(QObject *parent = nullptr, Database *database = new Database());

    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString id READ id)
    QString name();
    QString id();
    Q_INVOKABLE void setName(QString name, QString id);

signals:
    void nameChanged(QString name);
private:
    QString m_name;
    QString m_id;
    Database *m_database;
};

#endif // MODEL_H
