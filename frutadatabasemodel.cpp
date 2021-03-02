#include "frutadatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QDebug>
//FrutaDatabaseModel::FrutaDatabaseModel(Database *database, QObject *parent)
//    : QSqlTableModel(this, database->database())
//    ,m_db(*database)
//{
//    setTable("fruta");
//    this->select();
//    this->configureRoles();
//}

FrutaDatabaseModel::FrutaDatabaseModel(QObject *parent, Database *database) : QSqlTableModel(parent, database->database())
{
    setTable("fruta");
    this->configureRoles();
    this->select();
}

void FrutaDatabaseModel::configureRoles()
{
    registerRoleColumn(Id, "id");
    registerRoleColumn(Name, "nome");
    registerRoleColumn(Price, "preco");
    registerRoleColumn(Calories, "calorias");
}

QHash<int, QByteArray> FrutaDatabaseModel::roleNames() const
{
    return m_roleColumns;
}

void FrutaDatabaseModel::registerRoleColumn(int role, QByteArray columnName)
{
    m_roleColumns.insert(role, columnName);
}

//QVariant FrutaDatabaseModel::data(int row, int role) const
//{
//    qDebug() << "row & role";
//    if(m_roleColumns.contains(role)) {
//        int column = fieldIndex(m_roleColumns.value(role));
//        QModelIndex itemListIndex = QSqlTableModel::index(row, column);
//        return QSqlTableModel::data(itemListIndex);
//    }
//    return QVariant();
//}

QVariant FrutaDatabaseModel::data(const QModelIndex &index, int role) const
{
    qDebug() << role << index.row() << m_roleColumns.value(role);
    if(m_roleColumns.contains(role)) {
        int column = fieldIndex(m_roleColumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void registerTypes() {
    qmlRegisterType<FrutaDatabaseModel>("Models", 1, 0, "FrutaDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes)
