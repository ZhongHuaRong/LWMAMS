#include <QApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include "CodeArea.h"
#include "DataShowPara.h"
#include "Manual.h"
#include "TreeModel.h"
#include "ClientManagement.h"
#include "TcpClient.h"
#include "MsgBox.h"
#include "RouteManage.h"
#include "TableData.h"
#include "DateData.h"
#include "ChartViewData.h"
#include "TipMsgChart.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

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
    qmlRegisterType<ClientManagement>("an.qt.ClientManagement", 1, 0, "ClientManagement");
    qmlRegisterType<TcpClient>("an.qt.TcpClient", 1, 0, "TcpClient");
    qmlRegisterType<MsgBox>("an.qt.MsgBox", 1, 0, "MsgBox");
    qmlRegisterType<RouteManage>("an.qt.RouteManage", 1, 0, "RouteManage");
    qmlRegisterType<TableData>("an.qt.TableData", 1, 0, "TableData");
    qmlRegisterType<ChartViewData>("an.qt.ChartViewData", 1, 0, "ChartViewData");
    qmlRegisterType<DateData>("an.qt.DateData", 1, 0, "DateData");
    qmlRegisterType<TipMsgChart>("an.qt.TipMsgChart", 1, 0, "TipMsgChart");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("../LWMAMS/Resources/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
