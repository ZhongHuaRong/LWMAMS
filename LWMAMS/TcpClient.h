#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QThread>
#include "DataShowPara.h"

/**
 * @brief The TcpClient class
 * @anchor ZM
 * @network
 * 命令格式是:头CT,命令间隔$,结尾#
 */

class TcpClient : public QObject
{
    Q_OBJECT
public:
    enum CommandType{
        CT_SIGNUP = 0x10,
        CT_SIGNUPAUTO,
        CT_USERSLOGINELSEWHERE,
        CT_PARACHECKACCOUNTNUMBER,
        CT_PARACHECKAPPID,
        CT_REGISTERED,
        CT_DATASHOW,
        CT_ROUTE,
        CT_CONTROL,
        CT_ANALYSIS
    };
    Q_ENUM(CommandType)

public:
    explicit TcpClient(QObject *parent = nullptr);
    ~TcpClient();

signals:
    void result(TcpClient::CommandType ct,const QStringList& arg);
public slots:
    void receiverMessage();
    void connectionServer();
    void connectSuccess();
    void connectError(QAbstractSocket::SocketError);
    void sendMessage(CommandType ct,const QStringList& arg);
private:
    QTcpSocket *m_pSocket;
    QThread *m_pThread;
};

#endif // TCPCLIENT_H
