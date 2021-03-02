#ifndef FRUTALISTMODEL_H
#define FRUTALISTMODEL_H
#include <QCoreApplication>
#include <QAbstractListModel>
#include <QQmlEngine>
#include "fruta.h"

class FrutaListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        Name = Qt::UserRole + 1,
        Calories,
        Price
    };
    Q_ENUM(Roles)

    explicit FrutaListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE void addFruta();
    static void registerTypes();

public slots:
    void insertFruta(QString name, double price, int calories);
    void removeFruta(int index);

private:
    QList<Fruta> m_frutas;
};

#endif // FRUTALISTMODEL_H
