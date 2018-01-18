#include "FileOperatorThread.h"
#include <QFile>
#include <QDir>
#include <QApplication>
#include <QDebug>
#include <QTimer>

FileOperatorThread::FileOperatorThread(QObject *parent) : QObject(parent)
{
    thread = new QThread();
    this->moveToThread(thread);
    thread->start();

    m_slNumList <<QString::fromLocal8Bit("零")
            <<QString::fromLocal8Bit("一")
            <<QString::fromLocal8Bit("二")
            <<QString::fromLocal8Bit("三")
            <<QString::fromLocal8Bit("四")
            <<QString::fromLocal8Bit("五")
            <<QString::fromLocal8Bit("六")
            <<QString::fromLocal8Bit("七")
            <<QString::fromLocal8Bit("八")
            <<QString::fromLocal8Bit("九");
    m_slUnitList <<QString::fromLocal8Bit("亿")
             <<QString::fromLocal8Bit("千")
             <<QString::fromLocal8Bit("百")
             <<QString::fromLocal8Bit("十")
             <<QString::fromLocal8Bit("万")
             <<QString::fromLocal8Bit("千")
             <<QString::fromLocal8Bit("百")
             <<QString::fromLocal8Bit("十")
             <<"";
}

FileOperatorThread::~FileOperatorThread()
{
    if(thread)
    {
        thread->exit();
        thread->wait();
        delete thread;
    }
}

QString FileOperatorThread::num2ChineseChar(int num)
{
    QString str = QString::number(num);
    QString cChar;
    int numIndex;
    int unitIndex;
    for(int a=0;a<str.length();a++)
    {
        numIndex = str.at(a).toLatin1()-'0';
        unitIndex =a+m_slUnitList.length()-str.length();
        if(numIndex==0)
        {
            if(a!=0&&a!=str.length()-1)
                if(str.at(a+1)!='0')
                    cChar.append(m_slNumList.at(0));
        }
        else
        {
            if(str.length()!=2||a!=str.length()-2)
                cChar.append(m_slNumList.at(numIndex));
            cChar.append(m_slUnitList.at(unitIndex));
        }
    }
    return cChar;
}

QMutex *FileOperatorThread::getMutex()
{
    return &mutex;
}

void FileOperatorThread::loadText(QString name)
{
    QDir dir;
    if(!dir.exists(dir.currentPath()+"/Manual"))
        dir.mkdir(dir.currentPath()+"/Manual");
    dir.setCurrent(dir.currentPath()+"/Manual");
    QFile file(dir.currentPath()+"/"+name);
    if(!file.open(QFile::ReadOnly))
    {
        qDebug()<<"打开失败";
        return;
    }
    QTextStream textStream(&file);
    m_sList.clear();
    while (!textStream.atEnd())
    {
        m_sList.append(textStream.readLine());
    }

    startFindTitle();
}

void FileOperatorThread::loadLine(int startRow, int endRow)
{
    if(endRow ==-1)
        endRow = m_sList.length();

    int curRow = startRow;
    int curEndRow ;
    const int rowCount = 5;
    bool isFirst = true;
    while(curRow<=endRow)
    {
        curEndRow = curRow+rowCount>endRow?endRow:curRow+rowCount;
        loadPartText(curRow,curEndRow,isFirst);
        curRow = curEndRow+1;
        if(isFirst)
            isFirst =!isFirst;

        QEventLoop eventloop;
        QTimer::singleShot(100, &eventloop, SLOT(quit()));
        eventloop.exec();
    }
}

void FileOperatorThread::findSecondTitle(int parentNum)
{
    QList<int> list;
    QList<QString> listName;
    int first = m_lTitleNum.at(parentNum);
    int last = parentNum==m_lTitleNum.length()-1?m_sList.length()-1:m_lTitleNum.at(parentNum+1);

    QString str;
    int num=1;
    QString findText(QString::fromLocal8Bit("一、"));
    for(int a=first;a<last;a++)
    {
        str = m_sList.at(a);
        if(str.contains(findText))
        {
            list.append(a);
            listName.append(str);
            findText = num2ChineseChar(++num)+QString::fromLocal8Bit("、");
            //qDebug()<<str;
        }
    }
    m_lSecondTitleNum.append(list);
    m_lSecondTitleName.append(listName);
}

void FileOperatorThread::findFirstTitle()
{
    m_lTitleNum.clear();
    m_lTitleName.clear();

    int chapter = 1;
    QString findText(QString::fromLocal8Bit("第一节"));
    QString text;
    for(int a=0;a<m_sList.length();a++)
    {
        text = m_sList.at(a);
        if(text.contains(findText))
        {
            //存在章节
            m_lTitleNum.append(a);
            m_lTitleName.append(text);
            findText = QString::fromLocal8Bit("第")+num2ChineseChar(++chapter)+QString::fromLocal8Bit("节");
        }
    }
    //qDebug()<<"m_lTitleNum"<<m_lTitleNum;

    //debug
//    for(int n=0;n<m_lTitleNum.length();n++)
//    {
//        qDebug()<<"second:"<<n+1;
//        qDebug()<<findm_lSecondTitle(n);
//    }
}

void FileOperatorThread::startFindTitle()
{
    m_lSecondTitleNum.clear();
    m_lSecondTitleName.clear();
    findFirstTitle();
    for(int n=0;n<m_lTitleNum.length();n++)
    {
        findSecondTitle(n);
    }
    //emit returnSecondTitle(m_lSecondTitleNum,m_lSecondTitleName);

    QList<QList<QVariant>> list;
    QList<QVariant> list_data;
    QString text;
    for(int a=0;a<m_lTitleNum.length();a++)
    {
        list_data.clear();
        text = QString::fromLocal8Bit("第")+num2ChineseChar(a+1)+QString::fromLocal8Bit("节");
        list_data.append(text);
        list_data.append(m_lTitleName.at(a).split(QString::fromLocal8Bit(" ")).at(1));
        list_data.append(QString::number(m_lTitleNum.at(a)));
        list.append(list_data);
    }
    emit returnFirstTitle(list);

    QList<QList<QList<QVariant>>> listChild;
    list.clear();
    list_data.clear();
    for(int x=0;x<m_lTitleNum.length();x++,list.clear())
    {
        for(int y=0;y<m_lSecondTitleNum.at(x).length();y++,list_data.clear())
        {
            text = QString::number(y+1)+".";
            list_data.append(text);
            list_data.append(m_lSecondTitleName.at(x).at(y).split(QString::fromLocal8Bit("、")).at(1));
            list_data.append(QString::number(m_lSecondTitleNum.at(x).at(y)));
            list.append(list_data);
        }
        listChild.append(list);
    }
    emit returnSecondTitle(listChild);

//    for(int x=0;x<m_lTitleNum.length();x++)
//    {
//        for(int y=0;y<m_lSecondTitleNum.at(x).length();y++)
//        {
//            qDebug()<<listChild.at(x).at(y);
//        }
    //    }
}

void FileOperatorThread::loadPartText(int startRow, int endRow,bool isFirst)
{
    mutex.lock();
    m_slReturnList.clear();

    //这里<要说一下，由于在循环体内，所以在endRow前一行就停止循环，
    //参数endRow可以直接传下一节的页数
    for(int a =startRow;a<endRow;a++)
    {
        m_slReturnList.append(m_sList.at(a));
    }

    mutex.unlock();
    emit returnLine(m_slReturnList,isFirst);
}

