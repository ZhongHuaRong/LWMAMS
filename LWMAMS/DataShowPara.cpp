#include "DataShowPara.h"

DataShowPara::DataShowPara(QObject *parent) : QObject(parent)
{

}

void DataShowPara::setDataType(DATATYPE type)
{
    m_eDataType = type;
}

void DataShowPara::setChartype(CHARTTYPE type)
{
    m_eChartType = type;
}
