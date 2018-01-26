#ifndef ROUTENODE_H
#define ROUTENODE_H

#include <QObject>
#include <QQuickPaintedItem>
#include <QPainterPath>

class RouteNode : public QQuickPaintedItem
{
    Q_OBJECT
public:
    RouteNode(const QString & id,int nodeID,const QString &time,float latitude,float longitude,
              const QString &temp,const QString & ph,const QString & tur,
              QQuickPaintedItem *parent =nullptr);
protected:
    virtual void paint(QPainter *event);
    virtual void hoverEnterEvent(QHoverEvent *event);
    virtual void hoverLeaveEvent(QHoverEvent *event);
    virtual void mousePressEvent(QMouseEvent *event);
    virtual void mouseReleaseEvent(QMouseEvent *event);

signals:

public slots:

private:
    QString m_nID;
    int m_nNodeID;

    QString m_sTime;
    float m_fLatitude;
    float m_fLongitude;
    QString m_sTemp;
    QString m_sPH;
    QString m_sTur;
};

#endif // ROUTENODE_H
