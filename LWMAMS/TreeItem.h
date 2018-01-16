#ifndef TREEITEM_H
#define TREEITEM_H

#include <QList>
#include <QVariant>
#include <QStringList>
#include <QModelIndex>


class TreeItem :public QObject
{
    Q_OBJECT
public:
    TreeItem::TreeItem();
    TreeItem(const QList<QVariant> &data, TreeItem* parent);
    //TreeItem(const QVariant &data, TreeItem* parent);
    ~TreeItem();


    Q_INVOKABLE void appendChild(TreeItem *child);
    Q_INVOKABLE void appendChild(const QList<QVariant> &data);
    TreeItem * removeChild(TreeItem *item);
    void deleteAllChild();


    TreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    Q_INVOKABLE QVariant data(int column) const;
    bool setData(QVariant data,int column);
    int row() const;
    TreeItem *parent();
    void setParent(TreeItem *parent);
private:
    TreeItem *m_parentItem;
    QList<TreeItem*> m_childItems;
    QList<QVariant> m_itemData;
};

#endif // TREEITEM_H
