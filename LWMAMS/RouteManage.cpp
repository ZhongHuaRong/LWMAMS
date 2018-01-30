#include "RouteManage.h"
#include <QPainter>
#include <QDebug>

RouteManage::RouteManage(QQuickPaintedItem *parent) : QQuickPaintedItem(parent)
{
    setAcceptHoverEvents(true);
}

void RouteManage::addNode(const QList<QStringList> &list,
                          const float &tempMin,const float & tempMax,
                          const float & phMin,const float & phMax,
                          const float & turMin,const float & turMax,
                          const QString &latMin,const QString &latMax,
                          const QString &longMin,const QString &longMax)
{
    //qDebug()<<list;
    qDeleteAll(nodeList.begin(),nodeList.end());
    nodeList.clear();

    QList<QStringList>::const_iterator i;
    RouteNode * node;
    int n=1;
    double latMin_f = latMin.toDouble();
    double longMax_f = longMax.toDouble();
    double widthPercentage = latMax.toDouble() - latMin_f;
    double heightPercentage = longMax_f - longMin.toDouble();
    //计算相对位置的时候遇到0不好算，默认不算
    if(widthPercentage==0||heightPercentage ==0)
        return;

    widthPercentage = this->width()/widthPercentage;
    heightPercentage = this->height()/heightPercentage;
    qDebug()<<"widthPercentage:"<<widthPercentage;
    qDebug()<<"heightPercentage:"<<heightPercentage;
    qDebug()<<"width:"<<width();
    qDebug()<<"height:"<<height();
    for(i = list.constBegin();i!=list.constEnd();i++,n++)
    {
        //qDebug()<<"n:"<<n;
        if((*i).length()<6)
            continue;
        node = new RouteNode((*i).at(0),n,(*i).at(1),(*i).at(2).toDouble(),(*i).at(3).toDouble(),
                             (*i).at(4),(*i).at(5),(*i).at(6),
                             tempMin,tempMax,phMin,phMax,turMin,turMax,this);
        //相对位置
        node->setDCenterX(widthPercentage*((*i).at(2).toDouble()-latMin_f));
        node->setDCenterY(heightPercentage*(longMax_f -(*i).at(3).toDouble()));
        nodeList.append(node);

    }
    update();
}

void RouteManage::paint(QPainter *event)
{
    event->setRenderHint(QPainter::Antialiasing, true);

    QRectF target(0, 0, this->width(), this->height());
    QRectF source(0.0, 0.0, m_cqImage.width(), m_cqImage.height());
    event->drawImage(target, m_cqImage, source);
    //画线
    drawLine(event);

}

void RouteManage::hoverMoveEvent(QHoverEvent *event)
{
    //qDebug()<<"hoverMoveEvent:"<<event->pos();
}

void RouteManage::drawLine(QPainter *paint)
{
    double currentX;
    double currentY;
    double previousX;
    double previousY;
    int n = 0;
    paint->setPen(QPen(Qt::blue, 5, Qt::DashDotDotLine,
                       Qt::SquareCap, Qt::RoundJoin));
    foreach(RouteNode *node,nodeList)
    {
        currentX = node->x() + node->width()/2;
        currentY = node->y() + node->height()/2;
        //备注：误差超过这个范围将会出现界面卡顿，所以忽略这些点
        if(currentX <-5000||currentX>5000||currentY<-5000||currentY>5000)
            continue;
        if(n++!=0)
        {
            paint->drawLine(currentX,currentY,previousX,previousY);
            qDebug()<<currentX<<currentY<<previousX<<previousY;
        }
        previousX = currentX;
        previousY = currentY;
    }
}
