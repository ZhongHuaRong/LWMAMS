#include "TreeItem.h"
#include <QDebug>

TreeItem::TreeItem() :m_parentItem(nullptr)
{
}

TreeItem::TreeItem(const QList<QVariant> &data, TreeItem* parent) : m_parentItem(nullptr)
{
    if(parent)
    {
        this->setParent(parent);
    }

    m_itemData = data;
}

//TreeItem::TreeItem(const QVariant &data, TreeItem* parent)
//{
//    m_parentItem = parent;
//    m_itemData.append(data);
//}

TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *item)
{
    item->setParent(this);
    m_childItems.append(item);
}

void TreeItem::appendChild(const QList<QVariant> &data)
{
    TreeItem *item =new TreeItem();
    item->setParent(this);
    m_childItems.append(item);
    for(int a=0;a<data.length();a++)
        item->setData(data.at(a),a);
}

TreeItem * TreeItem::removeChild(TreeItem *item)
{
    TreeItem *child=nullptr;
    if(m_childItems.indexOf(item)!=-1)
    {
        child = m_childItems.takeAt(m_childItems.indexOf(item));
    }
    return child;
}

void TreeItem::deleteAllChild()
{
    for (int index = 0; index < m_childItems.size(); index++)
    {
        m_childItems[index]->deleteAllChild();
    }
    qDeleteAll(m_childItems);
    m_childItems.clear();
}

TreeItem *TreeItem::child(int row)
{
    return m_childItems.value(row);
}
int TreeItem::childCount() const
{
    return m_childItems.count();
}
int TreeItem::columnCount() const
{
    return m_itemData.count();
    //return 1;
}
QVariant TreeItem::data(int column) const
{
    if(column>m_itemData.length())
        return 0;
    else
        return m_itemData .value(column);
}

bool TreeItem::setData(QVariant data,int column)
{
    if(m_itemData.length()-1<column)
        m_itemData.insert(column,data);
    else
        m_itemData.replace(column,data);
    return true;
}

TreeItem *TreeItem::parent()
{
    return m_parentItem;
}

void TreeItem::setParent(TreeItem *parent)
{
    if(parent==nullptr)
    {
        return;
    }
    if(parent==m_parentItem)
        return;
    //先移除自己的父亲
    if(m_parentItem!=nullptr)
    {
        m_parentItem->removeChild(this);
    }
    m_parentItem = parent;
    m_parentItem->appendChild(this);


}
int TreeItem::row() const
{
    if (!m_parentItem) { return 0; }

    return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));
}
