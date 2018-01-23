#include "MsgBox.h"
#include <QApplication>

MsgBox::MsgBox(QObject *parent) :
    QObject(parent)
{
    beep();
}

MsgBox::~MsgBox()
{
}

void MsgBox::beep()
{
    QApplication::beep();
}
