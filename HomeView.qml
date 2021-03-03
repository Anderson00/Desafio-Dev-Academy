import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    property var numberOfColumns: 2
    property var numberOfColumnsAux: 0
    property var isGrid: true
    property var itemWidth: 110
    property var gridElem: grid

    signal changeIsGrid(bool toList);

    anchors.fill: parent


    ListModel{
        id:mod
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
        ListElement{
            name:"eee"
            nota:"eewee"
        }
    }


    GridView{
        id:grid



        anchors.fill: parent
        anchors.leftMargin: 10 - (isGrid)
        anchors.topMargin: 10
        ScrollBar.vertical: ScrollBar {
                visible: true
            }

        cellWidth: ((parent.width / numberOfColumns ) - 10/numberOfColumns)
        cellHeight: 120

        model:mod

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onWidthChanged: {
            //console.log(isGrid+' '+width+' '+numberOfColumns)
            if(isGrid){
                if(width <= 500){
                    numberOfColumns = 2;
                }else if(width <= 650){
                    numberOfColumns = 4;
                }else if(width <= 850){
                    numberOfColumns = 5;
                }else{
                    numberOfColumns = 5
                }
            }else{
                numberOfColumns = 1;
            }

        }

        delegate: Column{
            Card{
                width: grid.cellWidth - 10
                height: grid.cellHeight - 10

                Text {
                    text: name
                }
            }
        }
    }
}
