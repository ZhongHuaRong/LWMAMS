#ifndef DATASHOWPARA_H
#define DATASHOWPARA_H

#include <QObject>

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

    Q_ENUM(DATATYPE)
    Q_ENUM(CHARTTYPE)
public:
    explicit DataShowPara(QObject *parent = nullptr);

    Q_INVOKABLE void setDataType(DATATYPE);
    Q_INVOKABLE void setChartype(CHARTTYPE);
signals:

public slots:

private:
    DATATYPE m_eDataType;
    CHARTTYPE m_eChartType;
};

#endif // DATASHOWPARA_H
