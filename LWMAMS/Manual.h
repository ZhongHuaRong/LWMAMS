#ifndef MANUAL_H
#define MANUAL_H

#include <QObject>
#include <QList>
#include "TreeModel.h"
#include "FileOperatorThread.h"

//加多一个类是因为多线程操作需要QThread和moveToThrad，把类移动到线程中，所以多线程的类不能拥有父类，
//而qml必须赋值父类，所以加一个中间类来传送数据

class Manual : public QObject
{
    Q_OBJECT
public:
    enum TITLENUM{
        FirstTitle = 1,
        SecondTitle
    };
    Q_ENUM(TITLENUM)
public:
    explicit Manual(QObject *parent = nullptr);
    ~Manual();

    Q_INVOKABLE void setFileName(const QString & name);
    Q_INVOKABLE void startFindDirectory();
    Q_INVOKABLE void startFindDirectory(const QString & name);


    Q_INVOKABLE int titleSize(TITLENUM titleNum,int parent=-1);
    Q_INVOKABLE QVariantList firstTitleData(int index);
    Q_INVOKABLE QVariantList secondTitleData(int index,int parent);

    Q_INVOKABLE void startLoadText();
    Q_INVOKABLE void endLoadText();
signals:
    void startLoad(QString name);
    void loadTextOnThread(int startRow,int endRow);

    void loadTextOnQML(const QStringList & text,bool isFirst);
    void loadAll(const QString & list);
    void loadFirstTitle();
    void loadSecondTitle();
public slots:
    void getLine(const QStringList &text,bool isFirst);
    void getAll(const QString &text);

    void firstTitle(const QList<QList<QVariant>> &data);
    void secondTitle(const QList<QList<QList<QVariant>>> &data);
    void itemDoubleClicked(int row,int parentRow);
    void changedOnepage(bool isNext);
    void changedAll(bool isLast);
private:
    void gotoPage(int row,int parentRow);
private:
    FileOperatorThread *m_pThread;
    QString m_sFileName;
    QList<QList<QVariant>> m_lFTitle;
    QList<QList<QList<QVariant>>> m_lSTitle;
    int currentRow;
    int currentParent;
};

#endif // MANUAL_H
