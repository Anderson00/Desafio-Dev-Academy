#include "fruta.h"

Fruta::Fruta()
{

}

Fruta::Fruta(const QString &name, const double &price, const int &calories)
{
    this->name = name;
    this->price = price;
    this->calories = calories;
}
