#ifndef CHARTVIEWDATA_H
#define CHARTVIEWDATA_H

#include <QObject>
#include <QVariant>

class ChartViewData : public QObject
{
    Q_OBJECT
public:
    explicit ChartViewData(QObject *parent = nullptr);

    Q_INVOKABLE int setData(const QList<QStringList>& data);
    Q_INVOKABLE int rowCount();
    Q_INVOKABLE int columnCount();
    Q_INVOKABLE QVariant data(const int &row,const int &column);

signals:

public slots:
private:
    QList<QStringList> m_lData;
};

#endif // CHARTVIEWDATA_H
