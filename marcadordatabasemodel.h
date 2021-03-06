#ifndef MARCADORDATABASEMODEL_H
#define MARCADORDATABASEMODEL_H

#include <QObject>
#include <QtSql/QSqlTableModel>
#include "database.h"

class MarcadorDatabaseModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles {
        Id = Qt::UserRole + 1,
        Nome,
        NotaId
    };
    Q_ENUM(Roles)
    explicit MarcadorDatabaseModel(QObject *parent = nullptr, Database *database = new Database());

    void configureRoles();
    void registerRoleColumn(int role, QByteArray columnName);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void newRow(QString nome, QString notaId);
    Q_INVOKABLE void updateRow(QString id, QString nome);
    Q_INVOKABLE QVariantList getByNotaId(QString id);
    Q_INVOKABLE void deleteRow(QString id);

    Q_INVOKABLE QHash<int, QByteArray> roleNames() const;

private:
    Database m_db;
    QHash<int, QByteArray> m_roleColumns;

};

#endif // MARCADORDATABASEMODEL_H
