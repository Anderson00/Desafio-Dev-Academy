import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Item {
    property var nameWindow: 'Home'

    property var stack
    property var numberOfColumns: 2
    property var numberOfColumnsAux: 0
    property var isGrid: true
    property var itemWidth: 110
    property var gridElem: grid
    property var notaTable
    property var marcadorTable
    property var toolbar
    property var markersModel
    property var markersListView

    property var filter


    signal changeIsGrid(bool toList);

    anchors.fill: parent

    Component.onCompleted: {
        markersModel.clear();
        //markersModel.append({'nome':''});
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

            function search(text){
                if(text === undefined || text.trim().length === 0)
                    return true;
                text = text.trim().toLowerCase();
                return (titulo.trim().toLowerCase().includes(text)
                        || desc.trim().toLowerCase().includes(text)
                        || cor.trim().toLowerCase().includes(text)
                        || date.trim().toLowerCase().includes(text)
                       )
            }

            opacity: search(filter) ? 1 : 0.2
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
                        markersModel.clear();
                        markersModel.append({'nome':''});

                        stack.push('AdicionarNotaView.qml', {"idOfItem": id, "marcadorTable" : marcadorTable,"markersListView":markersListView, "markersModel":markersModel, "titulo": titulo, "desc":desc, "cor":cor, "date":date});
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
                    anchors.left: parent.left
                    width: parent.width
                    height: 20
                    anchors.bottomMargin: 2
                    anchors.leftMargin: 10


                    RowLayout{
                        spacing: 12
                        Layout.fillWidth: true
                        Repeater{
                            model: marcadorTable

                            delegate:
                                Label{
                                    visible: nota_id == notaID
                                    id:mc
                                    text: nome
                                    color:"black"
                                    font.pixelSize: 10


                                    Rectangle{
                                        radius:10
                                        anchors.centerIn: parent
                                        width: mc.width + 10
                                        height: mc.height + 5
                                        color: "#FFFFAA"
                                        z: -1
                                    }
                                }

//                                Rectangle{
//                                visible: nota_id == notaID
//                                width: 50
//                                height: mc.width
//                                radius:10
//                                color: "#FFFFAA"
//                                Label{
//                                    id:mc
//                                    anchors.centerIn: parent
//                                    text: nome
//                                    color:"black"
//                                    font.pixelSize: 10

//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
}
