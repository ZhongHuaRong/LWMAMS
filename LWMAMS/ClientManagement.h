#ifndef CLIENTMANAGEMENT_H
#define CLIENTMANAGEMENT_H

#include <QObject>
#include "TcpClient.h"

class ClientManagement : public QObject
{
    Q_OBJECT
public:
    explicit ClientManagement(QObject *parent = nullptr);

    Q_INVOKABLE void signup(QString name,QString pw);

signals:
    void startConnectionServer();
    void sendCmd(TcpClient::CommandType, const QStringList &arg);
    void signupResult(bool result,QString error);
public slots:
    void resultAnalysis(TcpClient::CommandType ct,const QStringList& arg);
private:
    TcpClient client;
};

#endif // CLIENTMANAGEMENT_H
