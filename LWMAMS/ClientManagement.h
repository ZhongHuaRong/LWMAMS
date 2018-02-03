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
    Q_INVOKABLE void getServerData(TcpClient::CommandType ct,
                                  int pageNum,
                                  int pageRow,
                                  bool isCheck,
                                  DataShowPara::DATATYPE compareType,
                                  DataShowPara::DATACOMPARE compare,
                                  QString checkData
                                  );
    Q_INVOKABLE void getTestData(int num);

signals:
    void startConnectionServer();
    void sendCmd(TcpClient::CommandType, const QStringList &arg);
    void sendCmd(TcpClient::CommandType, const QStringList &arg,const QVariantList &data);
    //void signupResult(bool result,QString error);
    void loginMessage(TcpClient::CommandType ct,bool result,const QString &message);
    void chartData(TcpClient::CommandType ct,const QList<QStringList> &list,int maxCount);
public slots:
    void resultAnalysis(TcpClient::CommandType ct,const QStringList& arg);
private:
    TcpClient client;
};

#endif // CLIENTMANAGEMENT_H
