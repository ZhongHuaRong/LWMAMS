import QtQuick 2.7
import QtCharts 2.2
import an.qt.ChartViewData 1.0
import an.qt.DataShowPara 1.0

Item {
    id:view

    property var tempSeries: 0
    property var phSeries: 0
    property var turSeries: 0
    property var data: 0

    function setData(updataFlag,type,chartType){

        if(!updataFlag){
            chart.removeAllSeries();
            tempSeries = 0;
            phSeries = 0;
            turSeries = 0;
        }

        switch(type){
        case DataShowPara.Temperature:
            tempSeries = chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            break;
        case DataShowPara.PH:
            phSeries= chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            break;
        case DataShowPara.Turbidity:
            turSeries= chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            break;
        case DataShowPara.AllData:
        default:
            tempSeries = chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            phSeries= chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            turSeries= chart.createSeries(
                        getSeriesType(chartType),
                        "温度",
                        xAxis,
                        yAxis);
            break;
        }

        for(var n=0;n<data.rowCount();n++){
            if(num){
                //
            }
            else{
                if(tempSeries)
                    tempSeries.append(getNewNode(n,4,chartType,tempSeries));
                if(phSeries)
                    phSeries.append(getNewNode(n,5,chartType,phSeries));
                if(turSeries)
                    turSeries.append(getNewNode(n,6,chartType,turSeries));
            }

        }

    }

    function getSeriesType(chartType){
        switch(chartType){
        case DataShowPara.LineSeriesChart:
            return ChartView.SeriesTypeLine;
        case DataShowPara.BarChart:
            return 0;
        case DataShowPara.PieChart:
            return 0;
        }
    }

    function getNewNode(row,column,seriesType,parent){
        switch(seriesType){
        case ChartView.SeriesTypeLine:
            return Qt.createQmlObject(
                        'import QtCharts 2.2;
                         XYPoint { x: '+data.data(row,1)+'; '+
                                  'y: '+data.data(row,column)+' }', parent, "dynamicSnippet");
        case ChartView.SeriesTypeArea:
            return ChartView.SeriesTypeArea;
        }
    }

    function setTable(){

    }

    function updateDataType(type,chartType){
        //
    }

    Component.onCompleted: {
    }

    ChartView{
        id:chart
        anchors.fill:parent
        animationOptions:ChartView.AllAnimations
        theme:ChartView.ChartThemeBlueCerulean
        dropShadowEnabled:true
    }

    DateTimeAxis{
        id:xAxis
    }

    ValueAxis{
        id:yAxis
    }


}
