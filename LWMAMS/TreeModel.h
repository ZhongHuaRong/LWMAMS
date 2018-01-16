#ifndef TREEMODEL_H
#define TREEMODEL_H

#include <QAbstractItemModel>
#include "TreeItem.h"
#include <QVariant>

class TreeModel : public QAbstractItemModel
{
    Q_OBJECT
public :
    enum ItemRoles {
        NUM = Qt::UserRole + 1,
        NAME,
        PAGE
    };
    Q_ENUM(ItemRoles)
public:
    explicit TreeModel(QObject *parent = nullptr);
    ~TreeModel();

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &index) const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void appendChild(const QModelIndex &index,const QModelIndex &parent = QModelIndex());
    bool setData(const QModelIndex &index, const QVariant &value, int role)override;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE TreeItem * rootItem() const;
    Q_INVOKABLE TreeItem * appendChild(const QList<QVariant> &data,TreeItem *parent = nullptr);
    Q_INVOKABLE void deleteAll();
    Q_INVOKABLE bool itemIsVaild(const QModelIndex& index);
    Q_INVOKABLE int  itemRow(const QModelIndex& index);

private:
    TreeItem *m_rootItem;
};

#endif // TREEMODEL_H
