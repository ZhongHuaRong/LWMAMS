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

/**
   * @函数意义:设置文本的名字
   * @作者:ZM
   * @param [in] name
   *            文本名字
   * @date 2018-1
   */
void Manual::setFileName(const QString &  name)
{
    m_sFileName = name;
}

/**
   * @函数意义:发送信号给FileOperatorThread，让其开始查找目录
   * @作者:ZM
   * @date 2018-1
   */
void Manual::startFindDirectory()
{
    emit startLoad(m_sFileName);
}

/**
   * @函数意义:这是一个重载函数
   * @作者:ZM
   * @param [in] name
   *            文件名
   * @date 2018-1
   */
void Manual::startFindDirectory(const QString &name)
{
    m_sFileName = name;
    emit startLoad(m_sFileName);
}

/**
   * @函数意义:返回目录的大小
   * @作者:ZM
   * @param [in] titleNum
   *            用来标识是一级目录还是二级目录
   * @param [in] parent
   *            用来标识父亲节点位置，-1则是顶级
   * @return 返回parent的子节点数量
   * @date 2018-1
   */
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

/**
   * @函数意义:返回二级标题的数据
   * @作者:ZM
   * @param [in] index
   *            节点位置
   * @param [in] parent
   *            父亲节点位置
   * @return   返回节点的数据
   * @date 2018-1
   */
QVariantList Manual::secondTitleData(int index,int parent)
{
    if(index>m_lSTitle.length()||index>m_lFTitle.length())
        return QVariantList();
    else
        return m_lSTitle.at(parent).at(index);
}

/**
   * @函数意义:使用互斥量，上锁，在中间组件调用上锁比在线程类中调用灵活一点
   * @作者:ZM
   * @date 2018-1
   */
void Manual::startLoadText()
{
    m_pThread->getMutex()->lock();
}

/**
   * @函数意义:使用互斥量，解锁
   * @作者:ZM
   * @date 2018-1
   */
void Manual::endLoadText()
{
    m_pThread->getMutex()->unlock();
}

/**
   * @函数意义:返回一级标题的数据
   * @作者:ZM
   * @param [in] index
   *            节点位置
   * @return   返回节点的数据
   * @date 2018-1
   */
QList<QVariant> Manual::firstTitleData(int index)
{
    if(index>m_lFTitle.length())
        return QVariantList();
    else
        return m_lFTitle.at(index);
}

/**
  * @函数意义:发送信号，让qml组件处理文本,这是一个受保护的槽函数，
  *          由FileOperatorThread类返回,将会发送loadTextOnQML信号
  * @作者:ZM
  * @param [in] text
  *             要传送的文本
  * @param [in] isFirst
  *             因为大量的文本不能一次传输，所以用来标识是否是文本的开头
  * @date 2018-1
  */
void Manual::getLine(const QStringList & text,bool isFirst)
{
    emit loadTextOnQML(text,isFirst);
}

/**
  * @函数意义:获取所有文本，这是一个受保护的槽函数，由FileOperatorThread类返回，将会发送loadAll信号
  * @作者:ZM
  * @param [in] text
  *         返回的文本
  * @date 2018-1
  */
void Manual::getAll(const QString &text)
{
    emit loadAll(text);
}

/**
  * @函数意义:受保护的槽函数,将会发送loadFirstTitle信号
  * @作者:ZM
  * @param [in] data
  *             发送过来的一级标题数据
  * @date 2018-1
  */
void Manual::firstTitle(const QList<QVariantList> &data)
{
    m_lFTitle = data;
    emit loadFirstTitle();
}

/**
  * @函数意义:受保护的槽函数,将会发送loadSecondTitle信号,然后设置页面为第一页
  * @作者:ZM
  * @param [in] data
  *             发送过来的二级标题数据
  * @date 2018-1
  */
void Manual::secondTitle(const QList<QList<QList<QVariant>>> &data)
{
    m_lSTitle =data;
    emit loadSecondTitle();
    changedToLastPage(false);
}

/**
  * @函数意义:这是一个槽函数，treeView的项目被双击时调用
  * @作者:ZM
  * @param [in] row
  *         被双击的项目所在的行数
  * @param [in] row
  *         被双击的项目的父亲节点所在的行数
  * @date 2018-1
  */
void Manual::itemDoubleClicked(int row, int parentRow)
{
    gotoPage(row,parentRow);
}

/**
  * @函数意义:这是一个槽函数，当需要固定跳转1页的时候调用
  * @作者:ZM
  * @param [in] isNext
  *            true时表示正向跳转，否则反向跳转
  * @date 2018-1
  */
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

/**
  * @函数意义:这是一个槽函数,跳转到首页或者尾页
  * @作者:ZM
  * @param [in] isLast
  *             true时调到尾页，否则首页
  * @date 2018-1
  */
void Manual::changedToLastPage(bool isLast)
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

/**
  * @函数意义:这是一个私有函数，跳转到某页(章节),通过给出的节点所在行数判断出起始行数和终止行数
  * @作者:ZM
  * @param [in] row
  *             该页的所在节点的行数
  * @param [in] parentRow
  *             该页所在的节点的父节点的行数
  * @date 2018-1
  */
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


