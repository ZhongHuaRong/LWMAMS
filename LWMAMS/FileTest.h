#ifndef FILETEST_H
#define FILETEST_H

#include <QObject>
#include <QtTest/QTest>
#include "Manual.h"

class FileTest : public QObject
{
    Q_OBJECT
public:
    explicit FileTest(QObject *parent = nullptr);

public slots:
    void loadSuccess();

private slots:
    void initTestCase();            //在测试开始前被调用
    void cleanupTestCase();         //在测试结束后被调用
    void onLoadManual();            //读取手册
    void onLoadManual_data();       //提供手册的数据
    void onTestUI();                //测试ManualView的响应
private:
    Manual manual;                  //读取文件功能模块

    bool finish;
};

#endif // FILETEST_H
