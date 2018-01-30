#ifndef ROUTEMANAGE_H
#define ROUTEMANAGE_H

#include <QObject>
#include <QQuickPaintedItem>
#include <QPainterPath>
#include <QImage>
#include "RouteNode.h"

class RouteManage : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit RouteManage(QQuickPaintedItem *parent = nullptr);

    Q_INVOKABLE void addNode(const QList<QStringList> &list,
                             const float &tempMin,const float & tempMax,
                             const float & phMin,const float & phMax,
                             const float & turMin,const float & turMax,
                             const QString &latMin,const QString &latMax,
                             const QString &longMin,const QString &longMax);

protected:
    void paint(QPainter *event);
    virtual void hoverMoveEvent(QHoverEvent *event);
signals:

public slots:
private:
    void drawLine(QPainter *paint);
private:
    const QImage m_cqImage = QImage(":/Resources/route.jpg");
    QList<RouteNode*> nodeList;

    float m_fTempMin;
    float m_fTempMax;
    float m_fPHMin;
    float m_fPHMax;
    float m_fTurMin;
    float m_fTurMax;

};

#endif // ROUTEMANAGE_H
