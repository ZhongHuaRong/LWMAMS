#include "FileTest.h"
#include <QQmlApplicationEngine>

FileTest::FileTest(QObject *parent) : QObject(parent)
{

}

void FileTest::loadSuccess()
{
    finish = true;
}

void FileTest::initTestCase()
{
    qRegisterMetaType<QList<QList<QVariant>>>("QList<QList<QVariant>>");
    qRegisterMetaType<QList<QList<QList<QVariant>>>>("QList<QList<QList<QVariant>>>");
    qmlRegisterType<Manual>("an.qt.Manual", 1, 0, "Manual");
    connect(&manual,&Manual::loadSecondTitle,this,&FileTest::loadSuccess);
    finish = false;
}

void FileTest::cleanupTestCase()
{

}

void FileTest::onLoadManual()
{
    finish = false;

    QFETCH(QString, name);

    manual.startFindDirectory(name);
    while(!finish)
        QTest::qWait(1);

    QVERIFY(true);
}

void FileTest::onLoadManual_data()
{
    // 添加数据列
    QTest::addColumn<QString>("name");
    // 添加测试数据
    QTest::newRow("养鱼手册") << "养鱼手册.txt" ;
    QTest::newRow("123") << "123.txt" ;
}

void FileTest::onTestUI()
{

}
