#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QThread>

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
        CT_USERSLOGINELSEWHERE
    };

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
