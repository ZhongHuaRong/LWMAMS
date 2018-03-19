import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

Calendar {
    id: calendar
    frameVisible: true
    //weekNumbersVisible: true
    selectedDate: new Date()
    focus: true

    property var changRange: 0

    style: CalendarStyle {
//        dayDelegate: Rectangle {//设置日期样式，使用了渐变式
//            gradient: Gradient {
//                GradientStop {
//                    position: 0.00
//                    color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
//                }
//                GradientStop {
//                    position: 1.00
//                    color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
//                }
//                GradientStop {
//                    position: 1.00
//                    color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
//                }
//            }

//            Label {
//                text: styleData.date.getDate()
//                anchors.centerIn: parent
//                color: styleData.valid ? "white" : "grey"
//            }

//            Rectangle {
//                width: parent.width
//                height: 1
//                color: "#555"
//                anchors.bottom: parent.bottom
//            }

//            Rectangle {
//                width: 1
//                height: parent.height
//                color: "#555"
//                anchors.right: parent.right
//            }
//        }
//        dayOfWeekDelegate: Item{//设置周的样式
//            Rectangle{
//                anchors.fill: parent
//                Text {
//                    id: weekTxt
//                    text:Qt.locale().dayName(styleData.dayOfWeek, control.dayOfWeekFormat)//转换为自己想要的周的内容的表达
//                    anchors.centerIn: parent
//                    color: styleData.selected?"green":"gray"
//                }
//            }
//        }
        navigationBar: Rectangle {
            id: rectangle//导航控制栏，控制日期上下选择等
                height: dateText.height * 3

                Rectangle {
                    color: Qt.rgba(1, 1, 1, 0.6)
                    height: 1
                    width: parent.width
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    height: 1
                    width: parent.width
                    color: "#ddd"
                }
                ToolButton {
                    id: previousMonth
                    width: parent.height
                    height: width-20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: dateText.left
                    anchors.rightMargin: 50
                    iconSource: "qrc:/Resources/direction_left.png"
                    onClicked: {
                        if(changRange)
                            control.showPreviousYear();
                        else
                            control.showPreviousMonth()
                    }
                }
                Label {
                    id: dateText
                    text: styleData.title
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    anchors.verticalCenter: parent.verticalCenter
                }
                ToolButton {
                    id: nextMonth
                    width: parent.height
                    height: width-20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: dateText.right
                    anchors.leftMargin: 40
                    iconSource: "qrc:/Resources/direction_right.png"
                    onClicked: {
                        if(changRange)
                            control.showNextYear();
                        else
                            control.showNextMonth()
                    }
                }
            }
    }
}

