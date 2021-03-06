#include "IntenetTest.h"
#include "DataShowPara.h"
#include <QDebug>

IntenetTest::IntenetTest(QObject *parent) : QObject(parent)
{

}

void IntenetTest::timeOut()
{
    QTest::qWait(100);
    int n = 0;
    do
    {
        if(!isReturn)
        {
            QTest::qWait(500);
        }
        else
            return;
    }while(n++<10);

    if(!isReturn)
    {
        result = false;
        message = QStringLiteral("超时");
    }
}

void IntenetTest::onLoginResult(TcpClient::CommandType ct, int result, const QString &message)
{
    isReturn = true;
    this->result = result;
    this->message = message;
}

void IntenetTest::onChartResult(TcpClient::CommandType ct, const QList<QStringList> &list, int maxCount)
{
    isReturn = true;
    this->ct = ct;
    this->result = true;
    this->dataCount = list.length();
    this->maxCount = maxCount;
}

void IntenetTest::initTestCase()
{
    client = new ClientManagement();
    isReturn = false;
    result = false;
    message.clear();

    connect(client,&ClientManagement::loginMessage,this,&IntenetTest::onLoginResult);
    connect(client,&ClientManagement::chartData,this,&IntenetTest::onChartResult);
}

void IntenetTest::cleanupTestCase()
{
    delete client;
}

void IntenetTest::onLogin()
{
    QFETCH(QString, accountNumber);
    QFETCH(QString, pw);

    isReturn = false;
    client->signup(accountNumber,pw);
    timeOut();

    QVERIFY2(result,message.toStdString().c_str());
}

void IntenetTest::onLogin_data()
{
    // 添加数据列
    QTest::addColumn<QString>("accountNumber");
    QTest::addColumn<QString>("pw");
    // 添加测试数据
    QTest::newRow("user1") << "1234" << "1234";
    QTest::newRow("user2") << "123" << "1234";
    QTest::newRow("user3") << "123" << "123";
    QTest::newRow("user4") << "11111" << "11111";
}

void IntenetTest::onRegistered()
{
    QFETCH(QString, account);
    QFETCH(QString, pw);
    QFETCH(QString, userName);
    QFETCH(QString, email);

    isReturn = false;
    client->registered(account,pw,userName,email);
    timeOut();

    QVERIFY2(result,message.toStdString().c_str());
}

void IntenetTest::onRegistered_data()
{
    // 添加数据列
    QTest::addColumn<QString>("account");
    QTest::addColumn<QString>("pw");
    QTest::addColumn<QString>("userName");
    QTest::addColumn<QString>("email");
    // 添加测试数据
    QTest::newRow("user1") << "123" << "123"<<"ZM"<<"1525491989@qq.com";
    QTest::newRow("user2") << "111123" << "zxczxc"<<"zxc"<<"1525491989@qq.com";
    QTest::newRow("user3") << "111123" << "123"<<"ZM"<<"1525491989@qq.com";
}

void IntenetTest::onGetData()
{
    QFETCH(TcpClient::CommandType, ct);
    QFETCH(int, pageNum);
    QFETCH(int, pageRow);

    isReturn = false;
    maxCount = 0;
    if(ct == TcpClient::CT_STATISTICS)
    {
        QFETCH(QString, datatype);
        QFETCH(QString, dateType);
        QFETCH(QString, dateTime);
        QFETCH(QString, showType);
        client->getStatisticsData(datatype,dateType,dateTime,showType);
    }
    else
        client->getServerData(ct,pageNum,pageRow,false,
                              DataShowPara::AllData,DataShowPara::Equal,QString());

    timeOut();

    QString msg;
    if(maxCount==0)
        msg = this->message;
    else
    {
        msg = QString::fromLocal8Bit("最大行数:%1,成功获取行数:%2").arg(QString::number(maxCount)).arg(dataCount);
    }

    qDebug()<<msg;
    QVERIFY2(result,msg.toStdString().c_str());
}

void IntenetTest::onGetData_data()
{
    // 添加数据列
    QTest::addColumn<TcpClient::CommandType>("ct");
    QTest::addColumn<int>("pageNum");
    QTest::addColumn<int>("pageRow");
    QTest::addColumn<QString>("datatype");
    QTest::addColumn<QString>("dateType");
    QTest::addColumn<QString>("dateTime");
    QTest::addColumn<QString>("showType");
    // 添加测试数据
    QTest::newRow("数据显示") << TcpClient::CT_DATASHOW << 0<<30;
    QTest::newRow("数据显示") << TcpClient::CT_DATASHOW << 10<<30;
    QTest::newRow("路劲显示") << TcpClient::CT_ROUTE << 0<<30;
    QTest::newRow("路劲显示") << TcpClient::CT_ROUTE << 11<<30;
    QTest::newRow("控制显示") << TcpClient::CT_CONTROL << 0<<30;
    QTest::newRow("控制显示") << TcpClient::CT_CONTROL << 11<<30;
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"temp"<<"day"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"temp"<<"day"<<"2017-6-20"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"temp"<<"month"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"temp"<<"year"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"ph"<<"day"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"ph"<<"month"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"ph"<<"year"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"tur"<<"day"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"tur"<<"month"<<"2017-6-17"<<"abnormal";
    QTest::newRow("数据统计显示") << TcpClient::CT_STATISTICS << 0<<30
                            <<"tur"<<"year"<<"2017-6-17"<<"abnormal";
}

