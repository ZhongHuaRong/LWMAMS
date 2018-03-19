import QtQuick 2.0
import an.qt.DataShowPara 1.0
import an.qt.TableData 1.0

Item {
    id:statisticsView

    property var client: 0
    property var para: 0

    function setData(list){
        data.resetData(list)

        switch(leftParaView.getDateType()){
        case "day":
        case "month":
            chartView.setPieQuantity(data.varData(0,0),
                                     data.varData(0,1),
                                     data.varData(0,2),
                                     leftParaView.getDateTime(),
                                     leftParaView.getDataTypeName(),
                                     leftParaView.getDateType());
            break;
        case "year":
            chartView.setYearChart(data,
                                   leftParaView.getDateTime(),
                                   leftParaView.getDataTypeName())
            break;
        }
    }

    function getStatisticsData(){
        if(client)
            client.getStatisticsData(leftParaView.getDataType(),leftParaView.getDateType(),
                                     leftParaView.getDateTime(),leftParaView.getShowType());
    }

    //临时借用Control的数据管理类
    TableData{
        id:data
    }

    StatisticsParaListView{
        id:leftParaView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width:400
        onGetData: {
            getStatisticsData();
        }
    }

    StatisticsChartView{
        id:chartView
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.left: leftParaView.right
        anchors.leftMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 1
        onBarClicked: {
            chartView.setPieQuantity(data.varData(index,0),
                                     data.varData(index,1),
                                     data.varData(index,2),
                                     leftParaView.getDateTime(),
                                     leftParaView.getDataTypeName());
        }
        onPieExit: {
            chartView.setYearChart(data,
                                   leftParaView.getDateTime(),
                                   leftParaView.getDataTypeName())
        }
    }

}
