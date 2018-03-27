#ifndef INTENETTEST_H
#define INTENETTEST_H

#include <QObject>
#include <QtTest/QTest>
#include "ClientManagement.h"

class IntenetTest : public QObject
{
    Q_OBJECT
public:
    explicit IntenetTest(QObject *parent = nullptr);

    void timeOut();
public slots:
    void onLoginResult(TcpClient::CommandType ct,int result,const QString &message);
    void onChartResult(TcpClient::CommandType ct,const QList<QStringList> &list,int maxCount);

private slots:
    void initTestCase();            //在测试开始前被调用
    void cleanupTestCase();         //在测试结束后被调用
    void onLogin();                 //测试登录
    void onLogin_data();            //登录样例
    void onRegistered();            //测试注册
    void onRegistered_data();       //注册样例
    void onGetData();               //测试获取数据
    void onGetData_data();          //测试获取数据样例

private:
    ClientManagement * client;      //网络模块
    bool isReturn;                  //标志服务器是否有返回信息
    TcpClient::CommandType ct;      //结果类型
    bool result;                    //结果
    QString message;                //服务器返回的信息
    int dataCount;                  //返回的数据行数
    int maxCount;                   //返回的最大行数
};

#endif // INTENETTEST_H
