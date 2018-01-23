#ifndef CLIENTMANAGEMENT_H
#define CLIENTMANAGEMENT_H

#include <QObject>
#include "TcpClient.h"

class ClientManagement : public QObject
{
    Q_OBJECT
public:
    explicit ClientManagement(QObject *parent = nullptr);

    Q_INVOKABLE void signup(QString name,QString pw,bool autoS=false);
    Q_INVOKABLE void checkAccountNumber(QString accountNumber);
    Q_INVOKABLE void registered(QString account,QString pw,QString userName);
    Q_INVOKABLE void dataShowData(int pageNum,
                                  int pageRow,
                                  bool isCheck,
                                  DataShowPara::DATATYPE compareType,
                                  DataShowPara::DATACOMPARE compare,
                                  float checkData
                                  );

signals:
    void startConnectionServer();
    void sendCmd(TcpClient::CommandType, const QStringList &arg);
    //void signupResult(bool result,QString error);
    void loginMessage(TcpClient::CommandType ct,bool result,const QString &message);
public slots:
    void resultAnalysis(TcpClient::CommandType ct,const QStringList& arg);
private:
    TcpClient client;
};

#endif // CLIENTMANAGEMENT_H
