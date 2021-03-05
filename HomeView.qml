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

    property var filter


    signal changeIsGrid(bool toList);

    anchors.fill: parent


    MarcadorDatabaseModel{
        id:marcadorDb
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

        model:notaTable

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onWidthChanged: {
            if(isGrid){
                if(width <= 500){
                    numberOfColumns = 2;
                }else if(width <= 650){
                    numberOfColumns = 3;
                }else if(width <= 1050){
                    numberOfColumns = 5;
                }else{
                    numberOfColumns = 7
                }
            }else{
                numberOfColumns = 1;
            }

        }


        delegate: Column{
            property var notaID: id

            opacity: (titulo.trim().toLowerCase().includes(filter.trim().toLowerCase())
                      || desc.trim().toLowerCase().includes(filter.trim().toLowerCase())
                      || cor.trim().toLowerCase().includes(filter.trim().toLowerCase())
                      || date.trim().toLowerCase().includes(filter.trim().toLowerCase())) ? 1 : 0.2
            Card{
                id:card
                elevation: 10
                width: grid.cellWidth - 10
                height: grid.cellHeight - 10
                cardColor: (cor.trim() == Material.background) ? Material.foreground : cor
                //borderColor: (cor.trim() == Material.background)? Material.accent : 'transparent'
                clip: true

                MouseArea{
                    anchors.fill: parent

                    onPressed: {
                        toolbar.date = date;
                        toolbar.idOfItem = id;
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

                    opacity: Material.theme == Material.Light? 0.4 : 0.2

                }

                Label{
                    width: parent.width
                    anchors.top: titleSeparator.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 10
                    clip: true
                    wrapMode: "NoWrap"
                    font.pixelSize: 13
                    elide: "ElideRight"
                    color: "black"

                    text: desc
                }

                Item {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 20
                    anchors.bottomMargin: 2


                    GridView{
                        visible: true
                        id:gridMarcadores
                        anchors.fill: parent
                        anchors.leftMargin: 2
                        anchors.rightMargin: 2
                        cellWidth: 34
                        cellHeight: 20


                        model:marcadorDb

                        delegate: Column{
                            Rectangle{
                                visible: nota_id == notaID
                                width: mc.width + 10
                                height: mc.height + 5
                                radius:10
                                color: "#FFFFAA"
                                Label{
                                    id:mc
                                    anchors.centerIn: parent
                                    text: nome
                                    color:"black"
                                    font.pixelSize: 10

                                }
                            }
                        }
                    }
                }



            }
        }
    }
}
