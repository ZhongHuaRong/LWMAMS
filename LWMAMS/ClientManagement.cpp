#include "ClientManagement.h"

ClientManagement::ClientManagement(QObject *parent) : QObject(parent)
{
    //qRegisterMetaType<TcpClient::CommandType>("TcpClient::CommandType");
    connect(this,&ClientManagement::startConnectionServer,&client,&TcpClient::connectionServer);
    connect(this,&ClientManagement::sendCmd,&client,&TcpClient::sendMessage);
    connect(&client,&TcpClient::result,this,&ClientManagement::resultAnalysis);
    emit startConnectionServer();
}

void ClientManagement::signup(QString name, QString pw)
{
    QStringList list;
    list<<name<<pw;
    emit sendCmd(TcpClient::CT_SIGNUP,list);
}

void ClientManagement::resultAnalysis(TcpClient::CommandType ct, const QStringList &arg)
{
    qDebug()<<ct;
    qDebug()<<arg;

    switch(ct)
    {
    case TcpClient::CT_SIGNUP:
    {
        bool result = arg.at(0).at(0).toLatin1()=='1'?true:false;
        if(result)
            emit signupResult(result,QString());
        else
        {
            if(arg.length()<2)
                emit signupResult(result,QString("An unknown error occurred"));
            else
                emit signupResult(result,arg.at(1));
        }
        break;
    }
    }
}
