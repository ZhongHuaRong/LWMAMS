#include "RouteNode.h"
#include <QDebug>
#include <QPainter>

RouteNode::RouteNode(const QString & id,int nodeID,const QString &time,
                     float latitude, float longitude,
                     const QString &temp, const QString &ph, const QString &tur,
                     QQuickPaintedItem *parent):
    QQuickPaintedItem(parent),
    m_nID(id),m_nNodeID(nodeID),m_sTime(time),m_fLatitude(latitude),m_fLongitude(longitude),
    m_sTemp(temp),m_sPH(ph),m_sTur(tur)
{
    this->setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::LeftButton);
}

/**
  * @函数意义:绘画事件,因为圆心在数据库中的点才比较合理，所以传入的数据要经过处理，往左上角移动半个身位
  *          才能让圆心在数据点上，这里不能移动，因为会超过对象的长宽而无法显示
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::paint(QPainter *event)
{
    event->setRenderHint(QPainter::Antialiasing, true);

    // 设置字体
    QFont font;
    font.setFamily("微软雅黑");
    font.setPixelSize(20);
    event->setFont(font);

    event->setPen(Qt::red);
    // 绘制圆
    event->drawEllipse(0,0, width(), height());

    // 绘制文本
    event->drawText(QRect(0,0,width(),height()),
                    Qt::AlignHCenter | Qt::AlignVCenter,
                    QString::number(m_nNodeID));
}

/**
  * @函数意义:进入事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::hoverEnterEvent(QHoverEvent *)
{
    qDebug()<<"hoverEnterEvent:"<<m_nNodeID;
}

/**
  * @函数意义:离开事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::hoverLeaveEvent(QHoverEvent *)
{
    qDebug()<<"hoverLeaveEvent:"<<m_nNodeID;
}

/**
  * @函数意义:鼠标按下事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::mousePressEvent(QMouseEvent *)
{
    qDebug()<<"mousePressEvent:"<<m_nNodeID;

}

/**
  * @函数意义:鼠标松开事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::mouseReleaseEvent(QMouseEvent *)
{

    qDebug()<<"mouseReleaseEvent:"<<m_nNodeID;
}

