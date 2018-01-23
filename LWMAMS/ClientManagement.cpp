#include "ClientManagement.h"

ClientManagement::ClientManagement(QObject *parent) : QObject(parent)
{
    //qRegisterMetaType<TcpClient::CommandType>("TcpClient::CommandType");
    connect(this,&ClientManagement::startConnectionServer,&client,&TcpClient::connectionServer);
    connect(this,&ClientManagement::sendCmd,&client,&TcpClient::sendMessage);
    connect(&client,&TcpClient::result,this,&ClientManagement::resultAnalysis);
    emit startConnectionServer();
}

/**
  * @函数意义:登陆判断
  * @作者:ZM
  * @param [in] name
  *             用户名
  * @param [in] pw
  *             密码
  * @param [in] autoS
  *             为真则是自动登陆
  * @date 2018-1
  */
void ClientManagement::signup(QString name, QString pw,bool autoS)
{
    QStringList list;
    list<<name<<pw;
    emit sendCmd(autoS?TcpClient::CT_SIGNUPAUTO:TcpClient::CT_SIGNUP,list);
}

/**
  * @函数意义:参数用户名的判断
  * @作者:ZM
  * @param [in] accountNumber
  *             用户名
  * @date 2018-1
  */
void ClientManagement::checkAccountNumber(QString accountNumber)
{
    QStringList list;
    list<<accountNumber;
    emit sendCmd(TcpClient::CT_PARACHECKACCOUNTNUMBER,list);
}

/**
  * @函数意义:注册新用户
  * @作者:ZM
  * @param [in] account
  *             账号
  * @param [in] pw
  *             密码
  * @param [in] userName
  *             用户名
  * @date 2018-1
  */
void ClientManagement::registered(QString account, QString pw, QString userName)
{
    QStringList list;
    list<<account<<pw<<userName;
    emit sendCmd(TcpClient::CT_REGISTERED,list);
}

/**
  * @函数意义:通过服务器查找数据
  * @作者:ZM
  * @param [in] pageNum
  *             页数
  * @param [in] pageRow
  *             一页的行数
  * @param [in] isCheck
  *             是否是查找，如果为false，将无视后面的参数
  * @param [in] compareType
  *             用于查找的数据类型
  * @param [in] compare
  *             用于比较的符号类型
  * @param [in] checkData
  *             用于比较的数值
  * @date 2018-1
  */
void ClientManagement::dataShowData(int pageNum, int pageRow, bool isCheck,
                                    DataShowPara::DATATYPE compareType,
                                    DataShowPara::DATACOMPARE compare,
                                    float checkData)
{

}

/**
  * @函数意义:服务器返回的信息处理
  * @作者:ZM
  * @param [in] ct
  *             命令类型
  * @param [in] arg
  *             参数列表
  * @date 2018-1
  */
void ClientManagement::resultAnalysis(TcpClient::CommandType ct, const QStringList &arg)
{
    qDebug()<<ct;
    qDebug()<<arg;

    bool result = arg.at(0).at(0).toLatin1()=='1'?true:false;

    switch(ct)
    {
    case TcpClient::CT_SIGNUP:
    case TcpClient::CT_SIGNUPAUTO:
    case TcpClient::CT_PARACHECKACCOUNTNUMBER:
    case TcpClient::CT_REGISTERED:
    {
        if(result)
            emit loginMessage(ct,result,QString());
        else
        {
            if(arg.length()<2)
                emit loginMessage(ct,result,QString("An unknown error occurred"));
            else
                emit loginMessage(ct,result,arg.at(1));
        }
        break;
    }
    }
}
