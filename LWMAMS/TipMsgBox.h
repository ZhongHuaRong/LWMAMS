#ifndef TIPMSGBOX_H
#define TIPMSGBOX_H

#include <QObject>
#include <QQuickPaintedItem>

class TipMsgBox : public QQuickPaintedItem
{
    Q_OBJECT
public:
    enum TipShowDirection{
        LeftTop =0x01,
        RightTop,
        LeftBottom,
        RightBottom
    };

    enum TipType{
        AllData = 0x01,
        OnlyPos
    };

public:
    TipMsgBox(const QString & id,int nodeID,const QString &time,double latitude,double longitude,
              const QString &temp,const QString & ph,const QString & tur,
              const QColor &tempColor,const QColor &phColor,const QColor &turColor,
              const double &x,const double &y,const double &width = 150,const double &height = 200,
              TipShowDirection dir=RightTop,
              QQuickPaintedItem *parent =nullptr);
    TipMsgBox(const double &x,const double &y,
              const double & latitude,const double & longitude,
              const double &width = 150,const double &height = 200,
              TipShowDirection dir=RightTop,
              QQuickPaintedItem *parent =nullptr);

    static TipMsgBox* CreateTipMsgBox(const QString & id,int nodeID,const QString &time,double latitude,double longitude,
                                      const QString &temp,const QString & ph,const QString & tur,
                                      const QColor &tempColor,const QColor &phColor,const QColor &turColor,
                                      const double &x,const double &y,const double &width = 150,const double &height = 200,
                                      TipShowDirection dir=RightTop,
                                      QQuickPaintedItem *parent =nullptr);
    static TipMsgBox* CreateTipMsgBox(const double &x,const double &y,
                                      const double & latitude,const double & longitude,
                                      const double &width = 150,const double &height = 200,
                                      TipShowDirection dir=RightTop,
                                      QQuickPaintedItem *parent =nullptr);
    static void DestroyTipMsgBox();

protected:
    virtual void paint(QPainter *event);

    void drawBackground(QPainter *event);
    void initGeometry(const double &x,const double &y,
                      const double &width,const double &height,
                      TipShowDirection dir);
signals:

public slots:
private:
    QString m_nID;
    int m_nNodeID;

    QString m_sTime;
    double m_dLatitude;
    double m_dLongitude;
    QString m_sTemp;
    QString m_sPH;
    QString m_sTur;

    qreal m_dTextStartY;

    QColor m_qTempColor;
    QColor m_qPHColor;
    QColor m_qTurColor;

    TipShowDirection m_eDirection;
    TipType m_eTipTye;

    static TipMsgBox *tipMsgBox;
};

#endif // TIPMSGBOX_H
