#ifndef FRUTADATABASEMODEL_H
#define FRUTADATABASEMODEL_H
#include <QtSql/QSqlTableModel>
#include "database.h"

class FrutaDatabaseModel: public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles {
        Id = Qt::UserRole + 1,
        Name,
        Calories,
        Price
    };
    Q_ENUM(Roles)
    explicit FrutaDatabaseModel(QObject *parent = nullptr, Database *database = new Database());
//    explicit FrutaDatabaseModel(Database *database, QObject *parent = nullptr);
    void configureRoles();
    void registerRoleColumn(int role, QByteArray columnName);
//    QVariant data(int row, int role) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QHash<int, QByteArray> roleNames() const;

private:
    Database m_db;
    QHash<int, QByteArray> m_roleColumns;
};

#endif // FRUTADATABASEMODEL_H
