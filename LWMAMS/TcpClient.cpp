#include "TcpClient.h"
#include <QDebug>

//#define SERVERIP "119.29.243.183"
#define SERVERIP "192.168.31.112"
#define SERVERPOST 48428

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    qRegisterMetaType<TcpClient::CommandType>("TcpClient::CommandType");
    m_pSocket = new QTcpSocket(this);
    connect(m_pSocket,&QTcpSocket::readyRead,this,&TcpClient::receiverMessage);
    connect(m_pSocket,&QTcpSocket::connected,this,&TcpClient::connectSuccess);
    connect(m_pSocket,SIGNAL(error(QAbstractSocket::SocketError)),
            this,SLOT(connectError(QAbstractSocket::SocketError)));

    m_pThread = new QThread();
    this->moveToThread(m_pThread);
    m_pThread->start();
}

TcpClient::~TcpClient()
{
    if(m_pThread->isRunning())
    {
        m_pThread->exit();
        m_pThread->wait();
    }
    delete m_pThread;
}

void TcpClient::receiverMessage()
{
    QByteArray ba;

    ba.resize(m_pSocket->bytesAvailable());
    m_pSocket->read(ba.data(),ba.size());
    qDebug()<<"receiver:"<<ba;

    QList<QByteArray> list = ba.split('#').at(0).split('$');
    CommandType ct = static_cast<CommandType>(list.at(0).at(0));
    QStringList strList;
    for(int a=1;a<list.length()-1;a++)
    {
        strList.append(list.at(a));
    }
    emit result(ct,strList);
}

void TcpClient::connectionServer()
{
    m_pSocket->connectToHost(SERVERIP,SERVERPOST);
}

void TcpClient::connectSuccess()
{
    qDebug()<<"连接成功";
}

void TcpClient::connectError(QAbstractSocket::SocketError error)
{
    qDebug()<<error;
    //connectionServer();
    switch(error)
    {
    case QAbstractSocket::ConnectionRefusedError:
        connectionServer();
        break;
    }
}

void TcpClient::sendMessage(TcpClient::CommandType ct, const QStringList& arg)
{
     char cmd = static_cast<char>(ct);
     QByteArray ba;
     ba.append(cmd);
     ba.append('$');

     foreach(QString a,arg)
     {
         ba.append(a);
         ba.append('$');
     }
     ba.append('#');
     if(m_pSocket!=nullptr)
         m_pSocket->write(ba);

     qDebug()<<ba;
}
