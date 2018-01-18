#include "Manual.h"
#include <QApplication>
#include <QDebug>

Manual::Manual(QObject *parent) : QObject(parent)
{
    m_pThread = new FileOperatorThread();

    QObject::connect(this,&Manual::startLoad,m_pThread,&FileOperatorThread::loadText);
    QObject::connect(this,&Manual::loadTextOnThread,m_pThread,&FileOperatorThread::loadLine);
    QObject::connect(m_pThread,&FileOperatorThread::returnLine,this,&Manual::getLine);
    //QObject::connect(m_pThread,&FileOperatorThread::returnAll,this,&Manual::getAll);
    QObject::connect(m_pThread,&FileOperatorThread::returnFirstTitle,this,&Manual::firstTitle);
    QObject::connect(m_pThread,&FileOperatorThread::returnSecondTitle,this,&Manual::secondTitle);

}

Manual::~Manual()
{
    if(m_pThread)
    {
        delete m_pThread;
    }
}

void Manual::setFileName(const QString &  name)
{
    m_sFileName = name;
}

void Manual::startFindDirectory()
{
    emit startLoad(m_sFileName);
}

void Manual::startFindDirectory(const QString &name)
{
    m_sFileName = name;
    emit startLoad(m_sFileName);
}

int Manual::titleSize(TITLENUM titleNum,int parent)
{
    switch(titleNum){
    case FirstTitle:
        return m_lFTitle.length();
        break;
    case SecondTitle:
        if(parent<0||parent>m_lSTitle.length())
            return -1;
        else
            return m_lSTitle.at(parent).length();
        break;
    }
    return 0;
}

QVariantList Manual::secondTitleData(int index,int parent)
{
    if(index>m_lSTitle.length()||index>m_lFTitle.length())
        return QVariantList();
    else
        return m_lSTitle.at(parent).at(index);
}

void Manual::startLoadText()
{
    m_pThread->getMutex()->lock();
}

void Manual::endLoadText()
{
    m_pThread->getMutex()->unlock();
}

QList<QVariant> Manual::firstTitleData(int index)
{
    if(index>m_lFTitle.length())
        return QVariantList();
    else
        return m_lFTitle.at(index);
}

void Manual::getLine(const QStringList & text,bool isFirst)
{
    emit loadTextOnQML(text,isFirst);
}

void Manual::getAll(const QString &text)
{
    emit loadAll(text);
}

void Manual::firstTitle(const QList<QVariantList> &data)
{
    m_lFTitle = data;
    emit loadFirstTitle();
}

void Manual::secondTitle(const QList<QList<QList<QVariant>>> &data)
{
    m_lSTitle =data;
    emit loadSecondTitle();
    changedAll(false);
}

void Manual::itemDoubleClicked(int row, int parentRow)
{
    emit gotoPage(row,parentRow);
}

void Manual::changedOnepage(bool isNext)
{
    if(isNext)
    {
        //分三种情况
        //1.主标题最后
        //2.次标题最后
        //3.最后主标题的此标题最后
        if(currentParent==-1)
        {
            if(currentRow ==m_lFTitle.length()-1)
                return;
            else
                gotoPage(currentRow+1,currentParent);
        }
        else if(currentParent!=m_lFTitle.length()-1)
        {
            if(currentRow == m_lSTitle.at(currentParent).length()-1)
                gotoPage(0,currentParent+1);
            else
                gotoPage(currentRow+1,currentParent);
        }
        else
        {
            if(currentRow == m_lSTitle.at(currentParent).length()-1)
                return;
            else
                gotoPage(currentRow+1,currentParent);
        }
    }
    else
    {
        if(currentParent==-1)
        {
            if(currentRow ==0)
                return;
            else
                gotoPage(currentRow-1,currentParent);
        }
        else if(currentParent!=0)
        {
            if(currentRow == 0)
                gotoPage(m_lSTitle.at(currentParent-1).length()-1,currentParent-1);
            else
                gotoPage(currentRow-1,currentParent);
        }
        else
        {
            if(currentRow == 0)
                return;
            else
                gotoPage(currentRow-1,currentParent);
        }
    }
}

void Manual::changedAll(bool isLast)
{
    if(isLast)
    {
        gotoPage(m_lSTitle.last().length()-1,m_lFTitle.length()-1);
    }
    else
    {
        gotoPage(0,0);
    }
}

void Manual::gotoPage(int row, int parentRow)
{
    currentParent = parentRow;
    currentRow = row;

    QList<QVariant> item;
    int endPage;
    if(parentRow ==-1)
    {
        if(row ==-1)
        {
            qDebug()<<"invaild item:(row:"<<row<<",parentRow:"<<parentRow<<")";
            return;
        }
        else
        {
            if(row >m_lFTitle.length()-1)
            {
                qDebug()<<"invaild item:(row:"<<row<<",parentRow:"<<parentRow<<")";
                return;
            }
            item = m_lFTitle.at(row);
            if(row!=m_lFTitle.length()-1)
                endPage=m_lFTitle.at(row+1).at(2).toInt();
            else
                endPage=-1;
        }
    }
    else if(parentRow>m_lFTitle.length())
    {
        qDebug()<<"invaild item:(row:"<<row<<",parentRow:"<<parentRow<<")";
        return;
    }
    else
    {
        if(row<0||row>m_lSTitle.at(parentRow).length()-1)
        {
            qDebug()<<"invaild item:(row:"<<row<<",parentRow:"<<parentRow<<")";
            return;
        }
        else
        {
            item = m_lSTitle.at(parentRow).at(row);
            if(row!=m_lSTitle.at(parentRow).length()-1)
                endPage=m_lSTitle.at(parentRow).at(row+1).at(2).toInt();
            else if(parentRow!=m_lSTitle.length()-1)
                endPage=m_lFTitle.at(parentRow+1).at(2).toInt();
            else
                endPage=-1;
        }
    }

    emit loadTextOnThread(item.at(2).toInt(),endPage);
}


