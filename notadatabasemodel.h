#ifndef NOTADATABASEMODEL_H
#define NOTADATABASEMODEL_H
#include <QObject>
#include <QtSql/QSqlTableModel>
#include "database.h"

class NotaDatabaseModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles {
        Id = Qt::UserRole + 1,
        Titulo,
        Desc,
        Cor,
        Date
    };
    Q_ENUM(Roles)
    explicit NotaDatabaseModel(QObject *parent = nullptr, Database *database = new Database());

    void configureRoles();
    void registerRoleColumn(int role, QByteArray columnName);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void newRow(QString titulo, QString desc, QString cor, QString date);
    Q_INVOKABLE void updateRow(QString id, QString titulo, QString desc, QString cor, QString date);
    //Q_INVOKABLE void deleteRow(QString id);

    Q_INVOKABLE QHash<int, QByteArray> roleNames() const;


private:
    Database m_db;
    QHash<int, QByteArray> m_roleColumns;
};

#endif // NOTADATABASEMODEL_H
