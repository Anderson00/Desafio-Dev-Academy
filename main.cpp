#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "model.h"
#include "controller.h"
#include "database.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Database *database = new Database();
//    database->openDatabase();
//    qDebug() << "database is connected: " << database->isConnected();

    Model *model = new Model(nullptr, database);
    Controller *controller = new Controller();
    controller->setModel(model);

    engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("myController", controller);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
