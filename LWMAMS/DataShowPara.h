#ifndef DATASHOWPARA_H
#define DATASHOWPARA_H

#include <QObject>
#include <QVariant>
#include <QTimer>

class DataShowPara : public QObject
{
    Q_OBJECT
public:
    enum DATATYPE{
        AllData = 1,
        Temperature,
        PH,
        Turbidity
    };
    enum CHARTTYPE{
        Table = 1,
        LineSeriesChart,
        BarChart,
        PieChart
    };
    enum DATACOMPARE{
        MoreThan = 1,
        Equal,
        LessThan
    };
    enum PAGETYPE{
        DataShow =1,
        Route,
        Control,
        Analysis,
        OtherType
    };

    Q_ENUM(DATATYPE)
    Q_ENUM(CHARTTYPE)
    Q_ENUM(DATACOMPARE)
    Q_ENUM(PAGETYPE)
public:
    explicit DataShowPara(QObject *parent = nullptr);
    ~DataShowPara();

    Q_INVOKABLE DATATYPE getEDataType() const;
    Q_INVOKABLE void setDataType(DATATYPE);

    Q_INVOKABLE CHARTTYPE getEChartType() const;
    Q_INVOKABLE void setChartType(CHARTTYPE);

    Q_INVOKABLE void setTempMinValue(const QVariant&);
    Q_INVOKABLE QVariant getTempMinValue() const;

    Q_INVOKABLE void setTempMaxValue(const QVariant&);
    Q_INVOKABLE QVariant getTempMaxValue() const;

    Q_INVOKABLE void setPHMinValue(const QVariant&);
    Q_INVOKABLE QVariant getPHMinValue() const;

    Q_INVOKABLE void setPHMaxValue(const QVariant&);
    Q_INVOKABLE QVariant getPHMaxValue() const;

    Q_INVOKABLE void setTurMinValue(const QVariant&);
    Q_INVOKABLE QVariant getTurMinValue() const;

    Q_INVOKABLE void setTurMaxValue(const QVariant&);
    Q_INVOKABLE QVariant getTurMaxValue() const;

    Q_INVOKABLE DATATYPE getEDataFilter_DataType() const;
    Q_INVOKABLE void setEDataFilter_DataType(const DATATYPE &);

    Q_INVOKABLE DATACOMPARE getEDatafilterCompare() const;
    Q_INVOKABLE void setEDatafilterCompare(const DATACOMPARE &);

    Q_INVOKABLE QString getSCompareValue() const;
    Q_INVOKABLE void setSCompareValue(const QString &);

    Q_INVOKABLE int getNPageNum() const;
    Q_INVOKABLE void setNPageNum(int nPageNum,bool isSendPara = true);
    Q_INVOKABLE int getNPageMaxNum() const;

    Q_INVOKABLE int getNpageRowCount() const;
    Q_INVOKABLE void setNpageRowCount(int npageRowCount);

    int getNMaxCount() const;
    Q_INVOKABLE void setNMaxCount(int nMaxCount);

    Q_INVOKABLE void checkButtonClick();
    Q_INVOKABLE void closeCheckButtonClick();

    Q_INVOKABLE bool getBAutoUpdate() const;
    Q_INVOKABLE void setBAutoUpdate(bool bAutoUpdate);

    Q_INVOKABLE PAGETYPE getEPageType() const;
    Q_INVOKABLE void setEPageType(const PAGETYPE &ePageType);

    Q_INVOKABLE QString getSLatitudeMin() const;
    Q_INVOKABLE void setSLatitudeMin(const QString &sLatitudeMin);

    Q_INVOKABLE QString getSLatitudeMax() const;
    Q_INVOKABLE void setSLatitudeMax(const QString &sLatitudeMax);

    Q_INVOKABLE QString getSLongitudeMin() const;
    Q_INVOKABLE void setSLongitudeMin(const QString &sLongitudeMin);

    Q_INVOKABLE QString getSLongitudeMax() const;
    Q_INVOKABLE void setSLongitudeMax(const QString &sLongitudeMax);

    Q_INVOKABLE QString getSControlIP() const;
    Q_INVOKABLE void setSControlIP(const QString &sControlIP);

    Q_INVOKABLE QString getSVideoIP() const;
    Q_INVOKABLE void setSVideoIP(const QString &sVideoIP);

Q_SIGNALS:
    Q_INVOKABLE void pageNumChanged(int pageNum);
    Q_INVOKABLE void pageMaxNumChanged(int pageMaxNum);
    Q_INVOKABLE void caveatValueChanged();
private:
    void initAll();
    void saveAll();

    void sendPara();

signals:
    void paraData(PAGETYPE pt,int pageNum,int pageRow,bool isCheck,
                  DATATYPE dataType,DATACOMPARE compare,QString value);
    void testData(int num);

public slots:
    void timerTimeOut();
private:
    DATATYPE m_eDataType;
    CHARTTYPE m_eChartType;

    QString m_sTempMinValueText;
    QString m_sTempMaxValueText;
    QString m_sPHMinValueText;
    QString m_sPHMaxValueText;
    QString m_sTurMinValueText;
    QString m_sTurMaxValueText;
    DATATYPE m_eDatafilterDatatype;
    DATACOMPARE m_eDatafilterCompare;
    QString m_sCompareValue;
    QString m_sLatitudeMin;
    QString m_sLatitudeMax;
    QString m_sLongitudeMin;
    QString m_sLongitudeMax;
    QString m_sControlIP;
    QString m_sVideoIP;

    PAGETYPE m_ePageType;

    bool m_bCheckFlag;
    bool m_bAutoUpdate;

    int m_nPageNum;
    int m_nPageMaxNum;
    int m_npageRowCount;
    int m_nMaxCount;

    int m_nTestNum;

    QTimer m_qTimer;
};

#endif // DATASHOWPARA_H
