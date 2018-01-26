#include "RouteManage.h"
#include <QPainter>
#include <QDebug>

RouteManage::RouteManage(QQuickPaintedItem *parent) : QQuickPaintedItem(parent)
{
    setAcceptHoverEvents(true);
}

void RouteManage::addNode(const QList<QStringList> &list)
{
    //qDebug()<<list;
    qDeleteAll(nodeList.begin(),nodeList.end());
    nodeList.clear();

    QList<QStringList>::const_iterator i;
    RouteNode * node;
    int n=1;
    for(i = list.constBegin();i!=list.constEnd();i++,n++)
    {
        if((*i).length()<6)
            continue;
        node = new RouteNode((*i).at(0),n,(*i).at(1),(*i).at(2).toFloat(),(*i).at(3).toFloat(),
                             (*i).at(4),(*i).at(5),(*i).at(6),this);
        node->setX(35*n);
        node->setY(35*n);
        node->setWidth(35);
        node->setHeight(35);
        node->setVisible(true);
        nodeList.append(node);
    }
}

void RouteManage::paint(QPainter *event)
{
    event->setRenderHint(QPainter::Antialiasing, true);

    QRectF target(0, 0, this->width(), this->height());
    QRectF source(0.0, 0.0, m_cqImage.width(), m_cqImage.height());
    event->drawImage(target, m_cqImage, source);

}

void RouteManage::hoverMoveEvent(QHoverEvent *event)
{
    qDebug()<<"hoverMoveEvent:"<<event->pos();
}

/**
  * @函数意义:获取最新的值，可能用户已经修改过
  * @作者:ZM
  * @date 2018-1
  */
void RouteManage::getLatestValue()
{

}
