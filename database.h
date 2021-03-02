#ifndef DATABASE_H
#define DATABASE_H
#include <QtSql/QSqlDatabase>

class Database
{
public:

    Database();
    bool openDatabase();
    QSqlDatabase &database();
    bool isConnected();
    bool runSqlScript(QSqlDatabase db, QString path);
private:
    QSqlDatabase m_db;

};

#endif // DATABASE_H
