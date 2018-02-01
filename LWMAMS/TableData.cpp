#include "TableData.h"
#include <QDebug>
#include <QtNetwork/QNetworkRequest>

TableData::TableData(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
}

TableData::~TableData()
{
    delete manager;
}

void TableData::setData(const QList<QStringList> &datalist)
{
    m_qList = datalist;
}

int TableData::getDataRow()
{
    return m_qList.length();
}

int TableData::getDataColumn()
{
    return !m_qList.length()?0:m_qList.first().length();
}

QVariant TableData::varData(const int &row, const int &column)
{
    if(row>=m_qList.length())
        return QVariant();
    const QStringList &list = m_qList.at(row);
    if(list.length()<=column)
        return QVariant();
    return QVariant(list.at(column));
}

void TableData::buttonStateChanged(int n,const QString & ip)
{
    int led;
    if(n==1||n==3)
        led = 1;
    else if(n == 2|| n == 4)
        led =2;
    QString url(QString("http://%1/cgi-bin/myled%2.cgi?led%3=%4").
                arg(ip).
                arg(led==1?"":"2").
                arg(QString::number(led)).
                arg(QString::number(n)));
    qDebug()<<"control url:"<<url;
    manager->get(QNetworkRequest(QUrl(url)));
}
