#include "TipMsgBox.h"
#include <QPainter>

TipMsgBox *TipMsgBox::tipMsgBox = nullptr;

TipMsgBox::TipMsgBox(const QString &id, int nodeID, const QString &time,
                     double latitude, double longitude,
                     const QString &temp, const QString &ph, const QString &tur,
                     const QColor &tempColor,const QColor &phColor,const QColor &turColor,
                     const double &x,const double &y,const double &width,const double &height,
                     TipShowDirection dir,
                     QQuickPaintedItem *parent):
    QQuickPaintedItem(parent),
    m_nID(id),m_nNodeID(nodeID),m_sTime(time),
    m_dLatitude(latitude),m_dLongitude(longitude),
    m_sTemp(temp),m_sPH(ph),m_sTur(tur),
    m_qTempColor(tempColor),m_qPHColor(phColor),m_qTurColor(turColor),
    m_eDirection(dir),m_eTipTye(AllData)
{
    initGeometry(x,y,width,height,dir);
}

TipMsgBox::TipMsgBox(const double &x,const double &y,
                     const double & latitude,const double & longitude,
                     const double &width,const double &height,
                     TipShowDirection dir,
                     QQuickPaintedItem *parent):
    QQuickPaintedItem(parent),
    m_dLatitude(latitude),m_dLongitude(longitude),
    m_eDirection(dir),m_eTipTye(OnlyPos)
{
    initGeometry(x,y,width,height,dir);

}

TipMsgBox *TipMsgBox::CreateTipMsgBox(const QString &id, int nodeID,
                                      const QString &time,
                                      double latitude, double longitude,
                                      const QString &temp, const QString &ph, const QString &tur,
                                      const QColor &tempColor, const QColor &phColor,
                                      const QColor &turColor,
                                      const double &x, const double &y,
                                      const double &width, const double &height,
                                      TipMsgBox::TipShowDirection dir,
                                      QQuickPaintedItem *parent)
{
    DestroyTipMsgBox();
    TipMsgBox::tipMsgBox = new TipMsgBox(id,nodeID,time,
                                         latitude,longitude,
                                         temp,ph,tur,
                                         tempColor,phColor,turColor,
                                         x,y,
                                         width,height,
                                         dir,parent);
    return TipMsgBox::tipMsgBox;
}

TipMsgBox *TipMsgBox::CreateTipMsgBox(const double &x,const double &y,
                                      const double & latitude,const double & longitude,
                                      const double &width,const double &height,
                                      TipShowDirection dir,
                                      QQuickPaintedItem *parent)
{
    DestroyTipMsgBox();
    TipMsgBox::tipMsgBox = new TipMsgBox(x,y,
                                         latitude,longitude,
                                         width,height,
                                         dir,parent);
    return TipMsgBox::tipMsgBox;
}

void TipMsgBox::DestroyTipMsgBox()
{
    if(TipMsgBox::tipMsgBox)
    {
        delete TipMsgBox::tipMsgBox;
        TipMsgBox::tipMsgBox =nullptr;
    }

}

void TipMsgBox::paint(QPainter *event)
{
    drawBackground(event);
    QColor color(68,82,102);
    color.setAlpha(255);
    QFont font;
    font.setFamily("微软雅黑");
    font.setPixelSize(15);
    event->setPen(color);
    event->setFont(font);
    int textSpacint = 17;

    switch(m_eTipTye)
    {
    case AllData:
    {
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString("id:%1").arg(m_nID));
        m_dTextStartY+=textSpacint;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("节点号: %1").arg(QString::number(m_nNodeID)));
        m_dTextStartY+=textSpacint;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("时间: %1").arg(m_sTime));
        m_dTextStartY+=textSpacint;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("经度: %1").arg(QString::number(m_dLatitude)));
        m_dTextStartY+=textSpacint;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("纬度: %1").arg(QString::number(m_dLongitude)));
        m_dTextStartY+=textSpacint;
        event->setPen(m_qTempColor);
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("温度: %1").arg(m_sTemp));
        m_dTextStartY+=textSpacint;
        event->setPen(m_qPHColor);
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("酸碱度: %1").arg(m_sPH));
        m_dTextStartY+=textSpacint;
        event->setPen(m_qTurColor);
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("浑浊度: %1").arg(m_sTur));
        break;
    }
    case OnlyPos:
    {
        m_dTextStartY+=10;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("经度: %1").arg(QString::number(m_dLatitude,'g',10)));
        m_dTextStartY+=textSpacint;
        event->drawText(QRect(0,m_dTextStartY,width(),textSpacint),Qt::AlignCenter,
                        QString::fromLocal8Bit("纬度: %1").arg(QString::number(m_dLongitude,'g',10)));
        break;
    }
    }


}

/**
  * @函数意义:初始化线框
  * @作者:ZM
  * @date 2018-1
  */
void TipMsgBox::drawBackground(QPainter *event)
{
    QPointF points[7];
    double turningPointHeight;
    double turningPointLeft;
    double turningPointRight;
    switch(m_eDirection)
    {
    case RightTop:
        m_dTextStartY = 0;
        turningPointHeight = height()*7/9;
        turningPointLeft = width()*2/9;
        turningPointRight = width()*3/9;
        points[0].setX(0);
        points[0].setY(height());
        points[1].setX(turningPointLeft);
        points[1].setY(turningPointHeight);
        points[2].setX(0);
        points[2].setY(turningPointHeight);
        points[3].setX(0);
        points[3].setY(0);
        points[4].setX(width()-1);
        points[4].setY(0);
        points[5].setX(width()-1);
        points[5].setY(turningPointHeight);
        points[6].setX(turningPointRight);
        points[6].setY(turningPointHeight);
        break;
    case RightBottom:
        turningPointHeight = height()*2/9;
        turningPointLeft = width()*2/9;
        turningPointRight = width()*3/9;
        m_dTextStartY = turningPointHeight;
        points[0].setX(0);
        points[0].setY(0);
        points[1].setX(turningPointLeft);
        points[1].setY(turningPointHeight);
        points[2].setX(0);
        points[2].setY(turningPointHeight);
        points[3].setX(0);
        points[3].setY(height()-1);
        points[4].setX(width()-2);
        points[4].setY(height()-1);
        points[5].setX(width()-2);
        points[5].setY(turningPointHeight);
        points[6].setX(turningPointRight);
        points[6].setY(turningPointHeight);
        break;
    case LeftTop:
        turningPointHeight = height()*7/9;
        turningPointLeft = width()*7/9;
        turningPointRight = width()*6/9;
        m_dTextStartY = 0;
        points[0].setX(width()-2);
        points[0].setY(height()-1);
        points[1].setX(turningPointLeft);
        points[1].setY(turningPointHeight);
        points[2].setX(width()-2);
        points[2].setY(turningPointHeight);
        points[3].setX(width()-2);
        points[3].setY(0);
        points[4].setX(0);
        points[4].setY(0);
        points[5].setX(0);
        points[5].setY(turningPointHeight);
        points[6].setX(turningPointRight);
        points[6].setY(turningPointHeight);
        break;
    case LeftBottom:
        turningPointHeight = height()*2/9;
        turningPointLeft = width()*7/9;
        turningPointRight = width()*6/9;
        m_dTextStartY = turningPointHeight;
        points[0].setX(width()-2);
        points[0].setY(0);
        points[1].setX(turningPointLeft);
        points[1].setY(turningPointHeight);
        points[2].setX(width()-2);
        points[2].setY(turningPointHeight);
        points[3].setX(width()-2);
        points[3].setY(height()-2);
        points[4].setX(0);
        points[4].setY(height()-2);
        points[5].setX(0);
        points[5].setY(turningPointHeight);
        points[6].setX(turningPointRight);
        points[6].setY(turningPointHeight);
        break;
    }
    QColor color(255,255,255);
    color.setAlpha(200);
    event->setBrush(color);
    event->drawConvexPolygon(points,7);
}

void TipMsgBox::initGeometry(const double &x, const double &y, const double &width, const double &height, TipMsgBox::TipShowDirection dir)
{
    this->setHeight(height);
    this->setWidth(width);
    switch(dir)
    {
    case RightTop:
        setX(x);
        setY(y-height);
        break;
    case RightBottom:
        setX(x);
        setY(y);
        break;
    case LeftTop:
        setX(x-width);
        setY(y-height);
        break;
    case LeftBottom:
        setX(x-width);
        setY(y);
        break;
    }

}
