#include "frutalistmodel.h"
#include <QAbstractListModel>
#include <QCoreApplication>

FrutaListModel::FrutaListModel(QObject *parent)
{

}

int FrutaListModel::rowCount(const QModelIndex &parent) const
{
    return m_frutas.size();
}

QVariant FrutaListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    switch(role) {
    case Name:
        return m_frutas.at(index.row()).name;
        break;
    case Price:
        return m_frutas.at(index.row()).price;
        break;
    case Calories:
        return m_frutas.at(index.row()).calories;
        break;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> FrutaListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Name] = "name";
    roles[Price] = "price";
    roles[Calories] = "calories";
    return roles;
}

void FrutaListModel::addFruta()
{
    beginResetModel();
    m_frutas.clear();
    m_frutas.append(Fruta("Abacaxi", 5.50, 100));
    m_frutas.append(Fruta("Morango", 12, 34));
    m_frutas.append(Fruta("Kiwi", 7.55, 163));
    m_frutas.append(Fruta("Tangerina", 3, 123));
    endResetModel();
}

void FrutaListModel::insertFruta(QString name, double price, int calories)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_frutas.append(Fruta(name, price, calories));
    endInsertRows();
}

void FrutaListModel::removeFruta(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    m_frutas.removeAt(index);
    endRemoveRows();
}

void registerListModelTypes() {
    qmlRegisterType<FrutaListModel>("Models", 1, 0, "FrutaListModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerListModelTypes)
