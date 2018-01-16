import QtQuick 2.0
import QtQuick.Controls 2.2
import an.qt.DataShowPara 1.0

Item {
    id:page
    width:1280
    height:720

    function changePage(index){
        switch(index){
        case 0:
            stack.replace(view);
            break;
        case 1:
            stack.replace(page_one);
            break;
        case 2:
            stack.replace(page_two);
            break;
        case 3:
            stack.replace(page_three);
            break;
        case 4:
            stack.replace(page_four);
            break;
        case 5:
            stack.replace(page_five);
            break;
        case 6:
            stack.replace(page_six);
            break;
        case 7:
            stack.replace(page_seven);
            break;

        }
    }

    DataShowPara{
        id:para
    }

    StackView{
        id: stack
        anchors.fill: parent

        Component{
            id: view
            Image{
                source:"qrc:/Resources/homeBackground.jpg"

                Text{
                    text:"大型水域养殖管理系统";
                    x:100
                    y:200
                    width:1000
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 80
                    font.family: "微软雅黑"
                    color: "#445266"
                }
            }

        }


        DataShowView{
            id:page_one
            para:para
        }

        RouteView{
            id:page_two
            para:para

        }

        ManualView{
            id:page_three

        }

        ControlView{
            id:page_four
            para:para
        }

        VideoView{
            id:page_five

        }

        AnalysisView{
            id:page_six
            para:para
        }

        Component{
            id:page_seven
            ShadowText{
                text:"大型水域";
                x:100
                y:200
                width:1000
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                pixelSize: 80
            }
        }
    }
}
