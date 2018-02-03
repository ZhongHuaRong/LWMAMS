#include "ChartViewData.h"

ChartViewData::ChartViewData(QObject *parent) : QObject(parent)
{

}

/**
  * @函数意义: 设置数据，如果是因为更新获取的数据，则返回1告诉chart只有一条新数据，否则返回0告诉chart全部更新
  * @作者:ZM
  * @param [in] data
  *             数据库获取到的数据
  * @return int
  *         1:只更新一条数据
  *         0:全部更新
  * @date 2018-2
  */
int ChartViewData::setData(const QList<QStringList> &data)
{
    if(m_lData.length()==0)
    {
        m_lData = data;
        return 0;
    }
    else
        m_lData = data;
    return 0;
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
    return QVariant(list.at(column));
}
