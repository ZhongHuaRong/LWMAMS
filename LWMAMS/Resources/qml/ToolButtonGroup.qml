import QtQuick 2.0

Item {
    id:group

    property var current: 0
    signal resetButton(var object);

    function clickObject(object){
        if(current===object)
            return;
        current = object;

        group.resetButton(object);
    }
}
