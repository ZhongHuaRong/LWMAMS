#ifndef DATEDATA_H
#define DATEDATA_H

#include <QObject>
#include <QDateTime>

class DateData : public QObject
{
    Q_OBJECT
public:
    explicit DateData(QObject *parent = nullptr);

    Q_INVOKABLE QDateTime long2Date(const qint64 &time);
    Q_INVOKABLE QString date2String(const QDateTime &time);

signals:

public slots:
private:
};

#endif // DATEDATA_H
