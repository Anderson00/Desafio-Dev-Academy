import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Item {
    property var stack
    property var numberOfColumns: 2
    property var numberOfColumnsAux: 0
    property var isGrid: true
    property var itemWidth: 110
    property var gridElem: grid
    property var notaTable
    property var toolbar

    signal changeIsGrid(bool toList);

    anchors.fill: parent

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

        model:notaTable

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
                elevation: 2
                width: grid.cellWidth - 10
                height: grid.cellHeight - 10
                cardColor:cor
                clip: true
                Component.onCompleted: {
                    console.log(date);
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        toolbar.date = date;
                        stack.push('AdicionarNotaView.qml', {"idOfItem": id, "titulo": titulo, "desc":desc, "cor":cor, "date":date});
                    }
                }

                Label{
                    id:lbTitle
                    width: parent.width
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 10
                    clip: true
                    elide: "ElideRight"
                    color: "black"
                    text: titulo
                }

                Rectangle{
                    id:titleSeparator
                    anchors.top: lbTitle.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    width: parent.width
                    height: 1
                    color: Material.background
                    opacity: Material.theme == Material.Light? 1 : 0.2

                }

                Label{
                    width: parent.width
                    anchors.top: titleSeparator.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 10
                    clip: true
                    wrapMode: "NoWrap"

                    elide: "ElideRight"
                    color: "black"

                    text: desc
                }

                RowLayout{
                    visible: false
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                    width: parent.width
                    clip:true
                    Rectangle{


                        width: mc.width + 10
                        height: mc.height + 5
                        radius:10
                        color: "#FFFFAA"
                        Label{
                            id:mc

                            anchors.centerIn: parent
                            text: "marcador"
                            color:"black"
                            font.pixelSize: 10

                        }
                    }

                    Rectangle{


                        width: mc2.width + 10
                        height: mc2.height + 5
                        radius:10
                        color: "#FFFFAA"
                        Label{
                            id:mc2

                            anchors.centerIn: parent
                            text: "marcador"
                            color:"black"
                            font.pixelSize: 10

                        }
                    }

                    Rectangle{


                        width: mc3.width + 10
                        height: mc3.height + 5
                        radius:10
                        color: "#FFFFAA"
                        Label{
                            id:mc3

                            anchors.centerIn: parent
                            text: "marcador"
                            color:"black"
                            font.pixelSize: 10

                        }
                    }
                }


            }
        }
    }
}
