#ifndef DATASHOWPARA_H
#define DATASHOWPARA_H

#include <QObject>
#include <QVariant>

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

    Q_ENUM(DATATYPE)
    Q_ENUM(CHARTTYPE)
    Q_ENUM(DATACOMPARE)
public:
    explicit DataShowPara(QObject *parent = nullptr);
    ~DataShowPara();

    Q_INVOKABLE void setDataType(DATATYPE);

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
    Q_INVOKABLE void setNPageNum(int nPageNum);
    Q_INVOKABLE int getNPageMaxNum() const;

    Q_INVOKABLE int getNpageRowCount() const;
    Q_INVOKABLE void setNpageRowCount(int npageRowCount);

    int getNMaxCount() const;
    void setNMaxCount(int nMaxCount);

    Q_INVOKABLE static DataShowPara* getDataShowPara();

Q_SIGNALS:
    Q_INVOKABLE void pageNumChanged(int pageNum);
    Q_INVOKABLE void pageMaxNumChanged(int pageMaxNum);
private:
    void initAllPara();

signals:

public slots:

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

    int m_nPageNum;
    int m_nPageMaxNum;
    int m_npageRowCount;
    int m_nMaxCount;

    static DataShowPara * m_pPara;
};

#endif // DATASHOWPARA_H
