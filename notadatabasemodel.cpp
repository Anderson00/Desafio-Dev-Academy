#include "notadatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QSqlQuery>
#include <QDebug>

NotaDatabaseModel::NotaDatabaseModel(QObject *parent, Database *database)
    :  QSqlTableModel(parent, database->database())
{
    setTable("Nota");
    this->configureRoles();
    this->setEditStrategy(QSqlTableModel::OnRowChange);
    this->select();
}

void NotaDatabaseModel::configureRoles()
{
    registerRoleColumn(Id, "id");
    registerRoleColumn(Titulo, "titulo");
    registerRoleColumn(Desc, "desc");
    registerRoleColumn(Cor, "cor");
    registerRoleColumn(Date, "date");
}

void NotaDatabaseModel::registerRoleColumn(int role, QByteArray columnName)
{
    m_roleColumns.insert(role, columnName);
}

QVariant NotaDatabaseModel::data(const QModelIndex &index, int role) const
{
    qDebug() << role << index.row() << m_roleColumns.value(role);
    if(m_roleColumns.contains(role)) {
        int column = fieldIndex(m_roleColumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void NotaDatabaseModel::newRow(QString titulo, QString desc, QString cor, QString date)
{
    QSqlQuery insertQuery(QSqlTableModel::database());
    insertQuery.prepare(
                "insert into Nota(titulo, desc, cor, date, user_id) "
                    "VALUES (:titulo, :desc, :cor, :date, :userid) "
        );
    insertQuery.bindValue(":titulo", titulo);
    insertQuery.bindValue(":desc", desc);
    insertQuery.bindValue(":cor", cor);
    insertQuery.bindValue(":date", date);
    insertQuery.bindValue(":userid", 1);
    insertQuery.exec();
    select();
}

void NotaDatabaseModel::updateRow(QString id, QString titulo, QString desc, QString cor, QString date)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare(
                "update Nota set titulo = :titulo, desc = :desc, cor = :cor, date = :date, user_id = :userid "
                "where id = :id"
        );
    updateQuery.bindValue(":id", id);
    updateQuery.bindValue(":titulo", titulo);
    updateQuery.bindValue(":desc", desc);
    updateQuery.bindValue(":cor", cor);
    updateQuery.bindValue(":date", date);
    updateQuery.bindValue(":userid", 1);
    updateQuery.exec();
    select();
}

void NotaDatabaseModel::deleteRow(QString id)
{
    QSqlQuery deleteQuery(QSqlTableModel::database());
    deleteQuery.prepare("delete from Nota where id = :id");
    deleteQuery.bindValue(":id", id);
    deleteQuery.exec();
    select();
}

QHash<int, QByteArray> NotaDatabaseModel::roleNames() const
{
    return m_roleColumns;
}

void registerTypes2() {
    qmlRegisterType<NotaDatabaseModel>("Models", 1, 0, "NotaDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes2)
