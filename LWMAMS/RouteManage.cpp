#include "RouteManage.h"
#include <QPainter>
#include <QDebug>

RouteManage::RouteManage(QQuickPaintedItem *parent) : QQuickPaintedItem(parent)
{
    setAcceptHoverEvents(true);
    connect(this,SIGNAL(widthChanged()),this,SLOT(onWindowChange()));
}

void RouteManage::addNode(const QList<QStringList> &list,
                          const float &tempMin,const float & tempMax,
                          const float & phMin,const float & phMax,
                          const float & turMin,const float & turMax,
                          const QString &latMin,const QString &latMax,
                          const QString &longMin,const QString &longMax)
{
    //qDebug()<<list;
    nodeMsgList = list;

    m_dTempMin = tempMin;
    m_dTempMax = tempMax;
    m_dPHMin = phMin;
    m_dPHMax = phMax;
    m_dTurMin = turMin;
    m_dTurMax = turMax;

    m_dLatMin = latMin.toDouble();
    m_dLatMax =latMax.toDouble();
    m_dLongMin = longMin.toDouble();
    m_dLongMax = longMax.toDouble();
    setNode();
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
    showTip(event->pos().x(),event->pos().y());
}

void RouteManage::hoverLeaveEvent(QHoverEvent *)
{
    TipMsgBox::DestroyTipMsgBox();
}

void RouteManage::onWindowChange()
{
    setNode();
    update();
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

void RouteManage::setNode()
{
    //qDebug()<<list;
    qDeleteAll(nodeList.begin(),nodeList.end());
    nodeList.clear();

    QList<QStringList>::const_iterator i;
    RouteNode * node;
    int n=1;

    double widthPercentage = m_dLatMax - m_dLatMin;
    double heightPercentage = m_dLongMax - m_dLongMin;
    //计算相对位置的时候遇到0不好算，默认不算
    if(widthPercentage==0||heightPercentage ==0)
        return;

    widthPercentage = this->width()/widthPercentage;
    heightPercentage = this->height()/heightPercentage;
    qDebug()<<"widthPercentage:"<<widthPercentage;
    qDebug()<<"heightPercentage:"<<heightPercentage;
    qDebug()<<"width:"<<width();
    qDebug()<<"height:"<<height();
    for(i = nodeMsgList.constBegin();i!=nodeMsgList.constEnd();i++,n++)
    {
        //qDebug()<<"n:"<<n;
        if((*i).length()<6)
            continue;
        node = new RouteNode((*i).at(0),n,(*i).at(1),(*i).at(2).toDouble(),(*i).at(3).toDouble(),
                             (*i).at(4),(*i).at(5),(*i).at(6),
                             m_dTempMin,m_dTempMax,m_dPHMin,m_dPHMax,m_dTurMin,m_dTurMax,this);
        //相对位置
        node->setDCenterX(widthPercentage*((*i).at(2).toDouble()-m_dLatMin));
        node->setDCenterY(heightPercentage*(m_dLongMax -(*i).at(3).toDouble()));
        nodeList.append(node);

    }
}

void RouteManage::showTip(const double &x,const double &y)
{
    TipMsgBox::TipShowDirection dir;
    double boxWidth,boxHeight;
    boxWidth =  150;
    boxHeight = 70;

    if(x+boxWidth>width())
    {
        //右
        if(y-boxHeight<0)
        {
            //上
            dir = TipMsgBox::LeftBottom;
        }
        else //if(y()+boxHeight>m_pParentItem->height())
        {
            //下
            dir = TipMsgBox::LeftTop;
        }
    }
    else
    {
        //左
        if(y-boxHeight<0)
        {
            //上
            dir = TipMsgBox::RightBottom;
        }
        else
        {
            //默认情况，也就是正常情况
            dir = TipMsgBox::RightTop;
        }
    }
    double lon,lat;
    lon = (x*(m_dLatMax-m_dLatMin))/width() + m_dLatMin;
    lat = ((height()-y)*(m_dLongMax-m_dLongMin))/height() +m_dLongMin;
    TipMsgBox::CreateTipMsgBox(x,y,lon,lat,boxWidth,boxHeight,dir,this);
}

double RouteManage::dLongMax() const
{
    return m_dLongMax;
}

double RouteManage::dLatMax() const
{
    return m_dLatMax;
}

double RouteManage::dLatMin() const
{
    return m_dLatMin;
}

double RouteManage::dLongMin() const
{
    return m_dLongMin;
}
