#include "marcadordatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QSqlQuery>
#include <QDebug>

MarcadorDatabaseModel::MarcadorDatabaseModel(QObject *parent, Database *database)
    : QSqlTableModel(parent, database->database())
{
    setTable("Marcador");
    this->configureRoles();
    this->setEditStrategy(QSqlTableModel::OnRowChange);
    this->select();
}


void MarcadorDatabaseModel::configureRoles()
{
    registerRoleColumn(Id, "id");
    registerRoleColumn(Nome, "nome");
    registerRoleColumn(NotaId, "nota_id");
}

void MarcadorDatabaseModel::registerRoleColumn(int role, QByteArray columnName)
{
    m_roleColumns.insert(role, columnName);
}

QVariant MarcadorDatabaseModel::data(const QModelIndex &index, int role) const
{
    qDebug() << role << index.row() << m_roleColumns.value(role);
    if(m_roleColumns.contains(role)) {
        int column = fieldIndex(m_roleColumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void MarcadorDatabaseModel::newRow(QString nome, QString notaId)
{
    QSqlQuery insertQuery(QSqlTableModel::database());
    insertQuery.prepare(
                "insert into Marcador(nome, nota_id) "
                    "VALUES (:nome, :nota_id) "
        );
    insertQuery.bindValue(":nome", nome);
    insertQuery.bindValue(":nota_id", notaId);
    insertQuery.exec();
    select();
}

void MarcadorDatabaseModel::updateRow(QString id, QString nome, QString notaId)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare(
                "update Marcador set nome = :nome, nota_id = :nota_id "
                "where id = :id"
        );
    updateQuery.bindValue(":id", id);
    updateQuery.bindValue(":nome", nome);
    updateQuery.bindValue(":nota_id", notaId);
    updateQuery.exec();
    select();
}

void MarcadorDatabaseModel::deleteRow(QString id)
{
    QSqlQuery deleteQuery(QSqlTableModel::database());
    deleteQuery.prepare("delete from Marcador where id = :id");
    deleteQuery.bindValue(":id", id);
    deleteQuery.exec();
    select();
}

QVariantList MarcadorDatabaseModel::getByNotaId(QString id)
{
    QVariantList list;

    QSqlQuery selectQuery(QSqlTableModel::database());
    selectQuery.prepare("select * from Marcador where nota_id = :id");
    selectQuery.bindValue(":id", id);
    selectQuery.exec();
    while(selectQuery.next()){

        list.push_back(selectQuery.value(1));
    }
    return list;
}

QHash<int, QByteArray> MarcadorDatabaseModel::roleNames() const
{
    return m_roleColumns;
}

void registerTypes3() {
    qmlRegisterType<MarcadorDatabaseModel>("Models", 1, 0, "MarcadorDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes3)

