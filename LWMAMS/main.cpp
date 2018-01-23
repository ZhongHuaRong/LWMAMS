#include <QApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include "CodeArea.h"
#include "DataShowPara.h"
#include "Manual.h"
#include "TreeModel.h"
#include "TreeItem.h"
#include "ClientManagement.h"
#include "TcpClient.h"
#include "MsgBox.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qApp->setApplicationName("LWMAMS");
    qApp->setOrganizationName("ZM");
    //qApp->setQuitOnLastWindowClosed(false);

	//注册，使C++类在qml中使用
    qRegisterMetaType<QList<QList<QVariant>>>("QList<QList<QVariant>>");
    qRegisterMetaType<QList<QList<QList<QVariant>>>>("QList<QList<QList<QVariant>>>");
    qmlRegisterType<CodeArea>("an.qt.CodeArea", 1, 0, "CodeArea");
    qmlRegisterType<DataShowPara>("an.qt.DataShowPara", 1, 0, "DataShowPara");
    qmlRegisterType<Manual>("an.qt.Manual", 1, 0, "Manual");
    qmlRegisterType<TreeModel>("an.qt.TreeModel", 1, 0, "TreeModel");
    qmlRegisterType<TreeItem>("an.qt.TreeItem", 1, 0, "TreeItem");
    qmlRegisterType<ClientManagement>("an.qt.ClientManagement", 1, 0, "ClientManagement");
    qmlRegisterType<TcpClient>("an.qt.TcpClient", 1, 0, "TcpClient");
    qmlRegisterType<MsgBox>("an.qt.MsgBox", 1, 0, "MsgBox");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("../LWMAMS/Resources/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
