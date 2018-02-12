import QtQuick 2.0
import QtQuick.Controls 2.2
import an.qt.DataShowPara 1.0
import an.qt.ClientManagement 1.0
import an.qt.TcpClient 1.0

Item {
    id:page
    width:1280
    height:720
    property var client: 0

    function changePage(index){

        switch(index){
        case 0:
            stack.replace(view);
            para.setEPageType(DataShowPara.OtherType)
            break;
        case 1:
            stack.replace(page_one);
            para.setEPageType(DataShowPara.DataShow)
            break;
        case 2:
            stack.replace(page_two);
            para.setEPageType(DataShowPara.Route)
            page_two.changePageUpdate();
            break;
        case 3:
            stack.replace(page_three);
            para.setEPageType(DataShowPara.OtherType)
            break;
        case 4:
            stack.replace(page_four);
            para.setEPageType(DataShowPara.Control)
            break;
        case 5:
            stack.replace(page_five);
            para.setEPageType(DataShowPara.OtherType)
            break;
        case 6:
            stack.replace(page_six);
            para.setEPageType(DataShowPara.Analysis)
            break;
        case 7:
            stack.replace(page_seven);
            para.setEPageType(DataShowPara.OtherType)
            break;

        }
    }

    function analyzeDataType(ct,list,maxCount){
        switch(ct){
        case TcpClient.CT_DATASHOW:
            page_one.setData(list);
            break;
        case TcpClient.CT_ROUTE:
            page_two.setData(list);
            break;
        case TcpClient.CT_CONTROL:
            page_four.setData(list);
            break;
        case TcpClient.CT_ANALYSIS:
            break;
        }
        para.setNMaxCount(maxCount);
    }

    DataShowPara{
        id:para
        onParaData:{
            if(client){
                switch(pt)
                {
                case DataShowPara.DataShow:
                    client.getServerData(TcpClient.CT_DATASHOW,
                                         pageNum,pageRow,isCheck,dataType,compare,value);
                    break;
                case DataShowPara.Route:
                    client.getServerData(TcpClient.CT_ROUTE,
                                         pageNum,pageRow,isCheck,dataType,compare,value);
                    break;
                case DataShowPara.Control:
                    client.getServerData(TcpClient.CT_CONTROL,
                                         pageNum,pageRow,isCheck,dataType,compare,value);
                    break;
                case DataShowPara.Analysis:
                    client.getServerData(TcpClient.CT_ANALYSIS,
                                         pageNum,pageRow,isCheck,dataType,compare,value);
                    break;
                }
            }
        }
        onTestData: client.getTestData(num);
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
            para:para

        }

        StatisticsView{
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
