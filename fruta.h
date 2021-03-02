#ifndef FRUTA_H
#define FRUTA_H
#include <QString>

class Fruta
{
public:
    Fruta();
    Fruta(const QString& name, const double& price, const int& calories);
    double price;
    int calories;
    QString name;
};

#endif // FRUTA_H
