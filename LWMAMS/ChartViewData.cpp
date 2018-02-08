#include "ChartViewData.h"
#include <QDebug>
#include <QDateTime>

ChartViewData::ChartViewData(QObject *parent) : QObject(parent)
{

}

/**
  * @函数意义: 设置数据(全部更新会导致界面有一点卡顿)，
  *           如果是因为更新获取的数据，则返回1告诉chart只有一条新数据，返回0告诉chart全部更新,
  *           返回-1则不更新
  * @作者:ZM
  * @param [in] data
  *             数据库获取到的数据
  * @return int
  *         1:只更新一条数据
  *         0:全部更新
  *         -1:不更新
  * @date 2018-2
  */
int ChartViewData::setData(const QList<QStringList> &data)
{
    if(m_lData.length()==0)
    {
        m_lData = data;
        return 0;
    }
    if(data.length()==0)
    {
        m_lData.clear();
        return 0;
    }

    if(m_lData.length() == data.length())
    {
        if(m_lData.first().first() == data.first().first()&&
                m_lData.last().first() ==data.last().first())
        {
            return -1;
        }

        if(m_lData.first().first()==data.at(1).first()&&
                m_lData.at(m_lData.length()-2).first() == data.last().first())
        {
            m_lData.insert(0,data.first());
            m_lData.removeLast();
            return 1;
        }

        m_lData.clear();
        m_lData = data;
        return 0;
    }
    else
    {
        //数据量不相等的时候只需判断有多少连续数据相同，其他情况一律全更新
        //暂时不优化
        return 0;
    }

    return -1;
}

int ChartViewData::rowCount()
{
    return m_lData.length();
}

int ChartViewData::columnCount()
{
    return rowCount()?m_lData.first().length():0;
}

QVariant ChartViewData::data(const int &row, const int &column)
{
    if(row>=m_lData.length())
        return QVariant();
    const QStringList &list = m_lData.at(row);
    if(list.length()<=column)
        return QVariant();

    if(column==1)
        return QDateTime::fromString(list.at(column),"yyyy-MM-dd hh:mm:ss");
    return QVariant(list.at(column));
}
