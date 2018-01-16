#include "TreeModel.h"
#include <QDebug>

TreeModel::TreeModel(QObject *parent)
    : QAbstractItemModel(parent),
      m_rootItem(new TreeItem)
{
//    TreeItem *item=new TreeItem({"1","yangyu","20"},m_rootItem);
//    TreeItem *item2=new TreeItem({"12","2qwe","330"},item);
//    item=new TreeItem({"2","qwe","30"},m_rootItem);
//    item2=new TreeItem();
//    item2->setData("12",0);
//    item2->setData("453",1);
//    item2->setData("789",2);
//    item2->setParent(item);

}

TreeModel::~TreeModel()
{
    if(m_rootItem){
        m_rootItem->deleteAllChild();
        delete m_rootItem;
    }
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
    switch(orientation)
    {
    case Qt::Horizontal:
        return roleNames()[role];
        break;
    case Qt::Vertical:
        return QVariant();
        break;
    }
    return QVariant();
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
//    qDebug()<<"index";
//    qDebug()<<"row:"<<row<<",column:"<<column;
//    if (!parent.isValid())
//        qDebug()<<"m_rootItem";
//    else
//        qDebug()<<static_cast<TreeItem*>(parent.internalPointer())->data(column);
    // FIXME: Implement me!
    if (!hasIndex(row, column, parent))
    {
        return QModelIndex();
    }

    TreeItem *parentItem;
    if (!parent.isValid())
    {
        parentItem = m_rootItem;
    }
    else
    {
        parentItem = static_cast<TreeItem*>(parent.internalPointer());
    }

    TreeItem *childItem = parentItem->child(row);
    if (childItem)
    {
        return createIndex(row, column, childItem);
    }
    else
    {
        return QModelIndex();
    }
}

QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
    if (!index.isValid())
    {
        return QModelIndex();
    }

    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    TreeItem *parentItem = childItem->parent();

    if (parentItem == m_rootItem)
    {
        //qDebug()<<"parent:m_rootItem";
        return QModelIndex();
    }

    //qDebug()<<"parent:"<<parentItem->row();
    return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    // FIXME: Implement me!
    TreeItem *parentItem;

    if (!parent.isValid())
    {
        parentItem = m_rootItem;
    }
    else
    {
        parentItem = static_cast<TreeItem*>(parent.internalPointer());
    }
    return parentItem->childCount();
}

int TreeModel::columnCount(const QModelIndex &parent) const
{
    return 3;
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
    if (parent.isValid())
    {
        return static_cast<TreeItem*>(parent.internalPointer())->columnCount();
    }
    else
    {
        return 3;
        return m_rootItem->columnCount();
    }
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    switch (role)
    {
    case NUM:
    {
        //qDebug()<<"data:"<<static_cast<TreeItem*>(index.internalPointer())->data(0);
        return static_cast<TreeItem*>(index.internalPointer())->data(0);
    }
    case NAME:
    {
        //qDebug()<<"data:"<<static_cast<TreeItem*>(index.internalPointer())->data(1);
        return static_cast<TreeItem*>(index.internalPointer())->data(1);
    }
    case PAGE:
    {
        //qDebug()<<"data:"<<static_cast<TreeItem*>(index.internalPointer())->data(2);
        return static_cast<TreeItem*>(index.internalPointer())->data(2);
    }
    }
	return QVariant();
}

void TreeModel::appendChild(const QModelIndex &index,const QModelIndex &parent)
{
    TreeItem *parentItem;
    if (!parent.isValid())
    {
        parentItem = m_rootItem;
    }
    else
    {
        parentItem = static_cast<TreeItem*>(parent.internalPointer());
    }

    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    if (childItem)
    {
        return parentItem->appendChild(childItem);
    }
}

bool TreeModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;
    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    switch (role)
    {
    case NUM:
    {
                  return childItem->setData(value,0);
    }
    case NAME:
    {
                  return childItem->setData(value,1);
    }
    case PAGE:
    {
                  return childItem->setData(value,2);
    }
    }
    return false;
}

QHash<int, QByteArray> TreeModel::roleNames() const
{
    //qDebug()<<"roleNames";
    QHash<int, QByteArray> names(QAbstractItemModel::roleNames());
    names[NUM] = "num";
    names[NAME] = "name";
    names[PAGE] = "page";
    return names;
}

TreeItem *TreeModel::rootItem() const
{
    return m_rootItem;
}

TreeItem * TreeModel::appendChild(const QList<QVariant> &data, TreeItem *parent)
{
    beginResetModel();
    if(parent ==nullptr)
        parent = m_rootItem;
    TreeItem *item =new TreeItem(data,parent);
    endResetModel();
    return item;
}

void TreeModel::deleteAll()
{
    m_rootItem->deleteAllChild();
}

bool TreeModel::itemIsVaild(const QModelIndex &index)
{
    return index.isValid();
}

int TreeModel::itemRow(const QModelIndex &index)
{
    return index.isValid()?static_cast<TreeItem*>(index.internalPointer())->row():-1;
}
