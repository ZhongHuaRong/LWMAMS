#include "DataShowPara.h"
#include <QSettings>
#include <QDebug>

DataShowPara::DataShowPara(QObject *parent) :
    QObject(parent)
{
    initAllPara();
    connect(&m_qTimer,&QTimer::timeout,this,&DataShowPara::timerTimeOut);
    qRegisterMetaType<DataShowPara::DATATYPE>("DATATYPE");
    qRegisterMetaType<DataShowPara::DATACOMPARE>("DATACOMPARE");
    qRegisterMetaType<DataShowPara::PAGETYPE>("PAGETYPE");
}

DataShowPara::~DataShowPara()
{
    QSettings settings;
    settings.beginGroup("DataShowPara");
    settings.setValue("TempMinValue",m_sTempMinValueText);
    settings.setValue("TempMaxValue",m_sTempMaxValueText);
    settings.setValue("PHMinValue",m_sPHMinValueText);
    settings.setValue("PHMaxValue",m_sPHMaxValueText);
    settings.setValue("TurMinValue",m_sTurMinValueText);
    settings.setValue("TurMaxValue",m_sTurMaxValueText);
    settings.setValue("PageRowCount",m_npageRowCount);
    settings.endGroup();
}

void DataShowPara::setDataType(DATATYPE type)
{
    m_eDataType = type;
}

void DataShowPara::setChartType(CHARTTYPE type)
{
    m_eChartType = type;
}

void DataShowPara::setTempMinValue(const QVariant& var)
{
    m_sTempMinValueText = var.toString();
}

QVariant DataShowPara::getTempMinValue() const
{
    return QVariant(m_sTempMinValueText);
}

void DataShowPara::setTempMaxValue(const QVariant& var)
{
    m_sTempMaxValueText = var.toString();
}

QVariant DataShowPara::getTempMaxValue() const
{
    return QVariant(m_sTempMaxValueText);
}

void DataShowPara::setPHMinValue(const QVariant& var)
{
    m_sPHMinValueText = var.toString();
}

QVariant DataShowPara::getPHMinValue() const
{
    return QVariant(m_sPHMinValueText);
}

void DataShowPara::setPHMaxValue(const QVariant& var)
{
    m_sPHMaxValueText = var.toString();
}

QVariant DataShowPara::getPHMaxValue() const
{
    return QVariant(m_sPHMaxValueText);
}

void DataShowPara::setTurMinValue(const QVariant& var)
{
    m_sTurMinValueText= var.toString();
}

QVariant DataShowPara::getTurMinValue() const
{
    return QVariant(m_sTurMinValueText);
}

void DataShowPara::setTurMaxValue(const QVariant& var)
{
    m_sTurMaxValueText= var.toString();
}

QVariant DataShowPara::getTurMaxValue() const
{
    return QVariant(m_sTurMaxValueText);
}

DataShowPara::DATACOMPARE DataShowPara::getEDatafilterCompare() const
{
    return m_eDatafilterCompare;
}

void DataShowPara::setEDatafilterCompare(const DATACOMPARE &eDatafilterCompare)
{
    m_eDatafilterCompare = eDatafilterCompare;
}

DataShowPara::DATATYPE DataShowPara::getEDataFilter_DataType() const
{
    return m_eDatafilterDatatype;
}

void DataShowPara::setEDataFilter_DataType(const DATATYPE &eDataFilter_DataType)
{
    m_eDatafilterDatatype = eDataFilter_DataType;
}

QString DataShowPara::getSCompareValue() const
{
    return m_sCompareValue;
}

void DataShowPara::setSCompareValue(const QString &sCompareValue)
{
    m_sCompareValue = sCompareValue;
}

int DataShowPara::getNPageNum() const
{
    return m_nPageNum;
}

/**
  * @函数意义:换页，需要发送数据请求
  * @作者:ZM
  * @date 2018-1
  */
void DataShowPara::setNPageNum(int nPageNum)
{
    if(m_nPageMaxNum>1)
    {
        if(nPageNum<0)
            m_nPageNum = m_nPageMaxNum-1;
        else if(nPageNum>m_nPageMaxNum)
            m_nPageNum = m_nPageMaxNum;
        else
            m_nPageNum = nPageNum;
    }
    else
        m_nPageNum = 0;
    emit pageNumChanged(m_nPageNum);
    sendPara();
}

int DataShowPara::getNPageMaxNum() const
{
    return m_nPageMaxNum;
}

int DataShowPara::getNpageRowCount() const
{
    return m_npageRowCount;
}

/**
  * @函数意义:更换行数，需要发送数据请求
  * @作者:ZM
  * @date 2018-1
  */
void DataShowPara::setNpageRowCount(int npageRowCount)
{
    m_npageRowCount = npageRowCount;
    sendPara();
}

int DataShowPara::getNMaxCount() const
{
    return m_nMaxCount;
}

void DataShowPara::setNMaxCount(int nMaxCount)
{
    m_nMaxCount = nMaxCount;
    m_nPageMaxNum = m_nMaxCount/m_npageRowCount -1;
}

/**
  * @函数意义:查找按钮点击，将发送查找信号
  * @作者:ZM
  * @date 2018-1
  */
void DataShowPara::checkButtonClick()
{
    sendPara(true);
}

void DataShowPara::initAllPara()
{
    QSettings settings;
    settings.beginGroup("DataShowPara");

    m_sTempMinValueText = settings.value("TempMinValue").toString();
    m_sTempMaxValueText = settings.value("TempMaxValue").toString();
    m_sPHMinValueText = settings.value("PHMinValue").toString();
    m_sPHMaxValueText = settings.value("PHMaxValue").toString();
    m_sTurMinValueText = settings.value("TurMinValue").toString();
    m_sTurMaxValueText = settings.value("TurMaxValue").toString();

    m_npageRowCount = settings.value("PageRowCount").toInt();
    settings.endGroup();

    m_eDataType = DataShowPara::AllData;
    m_eChartType = DataShowPara::Table;
    if(m_sTempMinValueText.isEmpty())
        m_sTempMinValueText = "15.00";
    if(m_sTempMaxValueText.isEmpty())
        m_sTempMaxValueText = "28.00";
    if(m_sPHMinValueText.isEmpty())
        m_sPHMinValueText = "5.00";
    if(m_sPHMaxValueText.isEmpty())
        m_sPHMaxValueText = "8.00";
    if(m_sTurMinValueText.isEmpty())
        m_sTurMinValueText = "50.00";
    if(m_sTurMaxValueText.isEmpty())
        m_sTurMaxValueText = "150.00";

    m_eDatafilterDatatype = DataShowPara::AllData;
    m_eDatafilterCompare = DataShowPara::MoreThan;
    m_sCompareValue = QString::number(0);

    m_nPageNum = -1;
    m_nPageMaxNum = 0;
    if(m_npageRowCount==0)
    {
        m_npageRowCount =10;
    }
    m_bAutoUpdate = true;
    m_bActivation = false;
}

void DataShowPara::sendPara(bool isCheck)
{
    if(!m_bActivation)
        return;
    emit paraData(m_nPageNum,
                  m_npageRowCount,
                  isCheck,
                  m_eDatafilterDatatype,
                  m_eDatafilterCompare,
                  m_sCompareValue);
}

void DataShowPara::timerTimeOut()
{
    sendPara();
}

bool DataShowPara::getBActivation() const
{
    return m_bActivation;
}

void DataShowPara::setBActivation(bool bActivation)
{
    m_bActivation = bActivation;
}

DataShowPara::PAGETYPE DataShowPara::getEPageType() const
{
    return m_ePageType;
}

void DataShowPara::setEPageType(const PAGETYPE &ePageType)
{
    m_ePageType = ePageType;
}

bool DataShowPara::getBAutoUpdate() const
{
    return m_bAutoUpdate;
}

void DataShowPara::setBAutoUpdate(bool bAutoUpdate)
{
    m_bAutoUpdate = bAutoUpdate;
    if(m_bAutoUpdate)
        m_qTimer.start(2000);
    else
        m_qTimer.stop();
}

