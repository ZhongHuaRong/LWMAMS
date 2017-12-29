#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "CodeArea.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qApp->setApplicationName("LWMAMS");
    qApp->setOrganizationName("ZM");
    //qApp->setQuitOnLastWindowClosed(false);

	//注册，使C++类在qml中使用
    qmlRegisterType<CodeArea>("an.qt.CodeArea", 1, 0, "CodeArea");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("../LWMAMS/Resources/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
