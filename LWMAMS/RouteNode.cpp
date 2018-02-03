#include "RouteNode.h"
#include <QDebug>
#include <QPainter>
#include <QRadialGradient>
#include <QTimer>

#define WIDTH qreal(35)
#define HEIGHT qreal(35)
#define FONTSIZE 20

RouteNode::RouteNode(const QString & id,int nodeID,const QString &time,
                     double latitude, double longitude,
                     const QString &temp, const QString &ph, const QString &tur,
                     const float& tempMin,const float&  tempMax,
                     const float&  phMin,const float&  phMax,
                     const float&  turMin,const float&  turMax,
                     QQuickPaintedItem *parent):
    QQuickPaintedItem(parent),
    m_nID(id),m_nNodeID(nodeID),m_sTime(time),m_dLatitude(latitude),m_dLongitude(longitude),
    m_sTemp(temp),m_sPH(ph),m_sTur(tur),oldSize(Normal),m_pParentItem(parent)
{
    this->setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::LeftButton);
    setAntialiasing(true);
    setWidth(WIDTH);
    setHeight(HEIGHT);

    m_nFontSize = FONTSIZE;
    m_qFontColor.setRgb(0,0,0);
    m_dCenterX = x();
    m_dCenterY = y();
    initColorList();
    setColor(tempMin,tempMax,phMin,phMax,turMin,turMax);
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

    //逆时针
    drawPie(event,0,0,width(),height(),-30*16,120*16,tempColor);

    drawPie(event,0,0,width(),height(), 90*16,120*16,phColor);

    drawPie(event,0,0,width(),height(), 210*16,120*16,turColor);

    // 绘制文本
    // 设置字体
    QFont font;
    font.setFamily("微软雅黑");
    font.setPixelSize(m_nFontSize);
    event->setFont(font);
    event->setPen(QPen(m_qFontColor));
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
    //qDebug()<<"hoverEnterEvent:"<<m_nNodeID;
    m_qFontColor.setRgb(135,206,235);
    changedSize(Big);
    showTip();
}

/**
  * @函数意义:离开事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::hoverLeaveEvent(QHoverEvent *)
{
    //qDebug()<<"hoverLeaveEvent:"<<m_nNodeID;
    m_qFontColor = Qt::black;
    changedSize(Normal);

    //destroyTip();
}

/**
  * @函数意义:鼠标按下事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::mousePressEvent(QMouseEvent *)
{
    //qDebug()<<"mousePressEvent:"<<m_nNodeID;
    changedSize(Small);

}

/**
  * @函数意义:鼠标松开事件
  * @作者:ZM
  * @date 2018-1
  */
void RouteNode::mouseReleaseEvent(QMouseEvent *)
{

    //qDebug()<<"mouseReleaseEvent:"<<m_nNodeID;
    changedSize(Big);
}

void RouteNode::initColorList()
{
    roundcolorList <<"#0000ff"<<"#00ccff"<<"#FFA500"<<"#ff3399"<<"#ff0033";
}

void RouteNode::setColor(const float &tempMin, const float &tempMax, const float &phMin,
                         const float &phMax, const float &turMin, const float &turMax)
{
    float temp = m_sTemp.toFloat();
    if(temp<tempMin)
        tempColor = roundcolorList.at(0);
    else if(temp<=tempMin + 2)
        tempColor = roundcolorList.at(1);
    else if(temp>tempMax)
        tempColor = roundcolorList.last();
    else if(temp>=tempMax - 2)
        tempColor = roundcolorList.at(3);
    else
        tempColor = roundcolorList.at(2);

    temp = m_sPH.toFloat();
    if(temp<phMin)
        phColor = roundcolorList.at(0);
    else if(temp<=phMin + 0.1)
        phColor = roundcolorList.at(1);
    else if(temp>phMax)
        phColor = roundcolorList.last();
    else if(temp>=phMax - 0.1)
        phColor = roundcolorList.at(3);
    else
        phColor = roundcolorList.at(2);

    temp = m_sTur.toFloat();
    if(temp<turMin)
        turColor = roundcolorList.at(0);
    else if(temp<=turMin + 10)
        turColor = roundcolorList.at(1);
    else if(temp>turMax)
        turColor = roundcolorList.last();
    else if(temp>=turMax - 10)
        turColor = roundcolorList.at(3);
    else
        turColor = roundcolorList.at(2);
}

void RouteNode::drawPie(QPainter *paint, qreal startX, qreal startY, qreal width,
                        qreal height, int startAngle, int spanAngle, QColor color)
{
    paint->setPen(Qt::NoPen);
    paint->setBrush(QBrush(color));
    paint->drawPie(startX,startY,width,height,startAngle,spanAngle);
}

void RouteNode::changedSize(RouteNode::NodeSize size)
{
    if(oldSize ==size)
        return;
    //防止鼠标过快
    qreal startWidth,startHeight,startX,startY,startFontSize;
    switch(oldSize)
    {
    case Small:
        startWidth = WIDTH/1.5;
        startHeight = HEIGHT/1.5;
        startFontSize = FONTSIZE/1.5;
        break;
    case Normal:
        startWidth = WIDTH;
        startHeight = HEIGHT;
        startFontSize = FONTSIZE;
        break;
    case Big:
        startWidth = WIDTH*2;
        startHeight = HEIGHT*2;
        startFontSize = FONTSIZE*2;
        break;
    }
    startX = m_dCenterX - startWidth/2;
    startY = m_dCenterY - startHeight/2;
    oldSize = size;

    qreal widthCValue,heightCValue,xCValue,yCValue,fontSize;
    switch(size)
    {
    case Small:
        widthCValue = (WIDTH/1.5)-startWidth;
        heightCValue = (HEIGHT/1.5)-startHeight;
        xCValue = (m_dCenterX - WIDTH/3)-startX;
        yCValue = (m_dCenterY - HEIGHT/3)-startY;
        fontSize = FONTSIZE/1.5 - startFontSize;
        break;
    case Normal:
        widthCValue = WIDTH-startWidth;
        heightCValue = HEIGHT-startHeight;
        xCValue = (m_dCenterX - WIDTH/2)-startX;
        yCValue = (m_dCenterY - HEIGHT/2)-startY;
        fontSize = FONTSIZE - startFontSize;
        break;
    case Big:
        widthCValue = (WIDTH*2)-startWidth;
        heightCValue = (HEIGHT*2)-startHeight;
        xCValue = (m_dCenterX - WIDTH)-startX;
        yCValue = (m_dCenterY - HEIGHT)-startY;
        fontSize = FONTSIZE*2 - startFontSize;
        break;
    }
    int num = 15;
    widthCValue/=num;
    heightCValue/=num;
    xCValue/=num;
    yCValue/=num;
    fontSize/=num;
    for(int a=0;a<num;a++)
    {
        this->setWidth(width()+widthCValue);
        this->setHeight(height()+heightCValue);
        this->setX(x()+xCValue);
        this->setY(y()+yCValue);
        m_nFontSize +=fontSize;
//        QEventLoop eventloop;
//        QTimer::singleShot(2, &eventloop, SLOT(quit()));
//        eventloop.exec();
    }

}

QQuickPaintedItem *RouteNode::pParentItem() const
{
    return m_pParentItem;
}

void RouteNode::setPParentItem(QQuickPaintedItem *pParentItem)
{
    m_pParentItem = pParentItem;
}

void RouteNode::showTip()
{
    //这个xy是指提示框尖点的坐标，不是起点（左上角）坐标
    //尖点坐标指的是圆形区域周围的四个点
    double tipX,tipY;
    TipMsgBox::TipShowDirection dir;
    double boxWidth,boxHeight;
    boxWidth =  200;
    boxHeight = 180;

    if(x()+boxWidth>m_pParentItem->width()-55)
    {
        //右
        if(y()-boxHeight<0)
        {
            //上
            dir = TipMsgBox::LeftBottom;
            tipX = x();
            tipY = y() + this->height();
        }
        else //if(y()+boxHeight>m_pParentItem->height())
        {
            //下
            dir = TipMsgBox::LeftTop;
            tipX = x();
            tipY = y();
        }
    }
    else
    {
        //左
        if(y()-boxHeight<0)
        {
            //上
            dir = TipMsgBox::RightBottom;
            tipX = x() + this->width();
            tipY = y() + this->height();
        }
        else
        {
            //默认情况，也就是正常情况
            dir = TipMsgBox::RightTop;
            tipX = x() + this->width();
            tipY = y();
        }
    }

    TipMsgBox::CreateTipMsgBox(m_nID,m_nNodeID,m_sTime,
                               m_dLatitude,m_dLongitude,
                               m_sTemp,m_sPH,m_sTur,
                               tempColor,phColor,turColor,
                               tipX,tipY,boxWidth,boxHeight,
                               dir,m_pParentItem);

}

void RouteNode::destroyTip()
{
    TipMsgBox::DestroyTipMsgBox();
}

qreal RouteNode::dCenterY() const
{
    return m_dCenterY;
}

void RouteNode::setDCenterY(const qreal &dCenterY)
{
    m_dCenterY = dCenterY;
    setY(m_dCenterY - this->height()/2);
}

qreal RouteNode::dCenterX() const
{
    return m_dCenterX;
}

void RouteNode::setDCenterX(const qreal &dCenterX)
{
    m_dCenterX = dCenterX;
    setX(m_dCenterX - this->width()/2);
}

double RouteNode::dLongitude() const
{
    return m_dLongitude;
}

void RouteNode::setDLongitude(double dLongitude)
{
    m_dLongitude = dLongitude;
}

double RouteNode::dLatitude() const
{
    return m_dLatitude;
}

void RouteNode::setDLatitude(double dLatitude)
{
    m_dLatitude = dLatitude;
}

QString RouteNode::sTur() const
{
    return m_sTur;
}

void RouteNode::setSTur(const QString &sTur)
{
    m_sTur = sTur;
}

QString RouteNode::sPH() const
{
    return m_sPH;
}

void RouteNode::setSPH(const QString &sPH)
{
    m_sPH = sPH;
}

QString RouteNode::sTemp() const
{
    return m_sTemp;
}

void RouteNode::setSTemp(const QString &sTemp)
{
    m_sTemp = sTemp;
}

QString RouteNode::sTime() const
{
    return m_sTime;
}

void RouteNode::setSTime(const QString &sTime)
{
    m_sTime = sTime;
}

int RouteNode::nNodeID() const
{
    return m_nNodeID;
}

void RouteNode::setNNodeID(int nNodeID)
{
    m_nNodeID = nNodeID;
}

QString RouteNode::nID() const
{
    return m_nID;
}

void RouteNode::setNID(const QString &nID)
{
    m_nID = nID;
}

