import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0

import Models 1.0

Item {
    id: root


    property var notaTable
    property var idOfItem //se for undefined, inserção, se não, update
    property var titulo
    property var desc
    property var cor
    property var date

    anchors.fill: parent
    Rectangle{
        id:rootBackground
        anchors.fill: parent
        color: Material.background
    }

    Component.onCompleted: {
        console.log(idOfItem);

//        if(idOfItem !== undefined){
//            tituloField.text = titulo;
//            notaField.text = desc;
//            rootBackground.color = cor;
//        }

        if(idOfItem){
            tituloField.text = titulo;
            notaField.text = desc;
            rootBackground.color = cor;
        }
    }

    Component.onDestruction: {
        //Salva a nota ou mudanças
        var current = new Date();
        var data = current.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
        var hora = current.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);

        if(idOfItem === undefined){

            notaTable.newRow(tituloField.text, notaField.text, rootBackground.color,
                             data+' '+ hora);
        }else{

            notaTable.updateRow(idOfItem, tituloField.text, notaField.text, rootBackground.color, data+' '+hora);
        }

        notaTable.select();
    }

    ColorDialog{
        id:dialog

        onAccepted: {
            anyColorItem.color = dialog.color;
            rootBackground.color = anyColorItem.color
        }
    }

    ColumnLayout{
        width: parent.width
        height: parent.height
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TextField{
            id:tituloField

            anchors.margins: 10
            Layout.fillWidth: true
            placeholderText: "Titulo"

            KeyNavigation.tab: notaField
        }
        Flickable {
            id:flickable
            Layout.fillHeight: true
            Layout.fillWidth:true
            flickableDirection: Flickable.VerticalFlick

            TextArea.flickable: TextArea {
                id: notaField
                placeholderText: "Nota"
                wrapMode: TextArea.Wrap
            }

            ScrollBar.vertical: ScrollBar {
                visible: true
            }

        }
        RowLayout{
            width: parent.width
            anchors.bottom: parent.bottom
            height: 0

            ListModel{
                id:mod
                ListElement{
                    textColor:"white"
                    colorItem:'black'
                }
                ListElement{
                    textColor:"black"
                    colorItem:'#f0df29'
                }
                ListElement{
                    textColor:"white"
                    colorItem:'#144ec9'
                }
                ListElement{
                    textColor:"black"
                    colorItem:'red'
                }
                ListElement{
                    textColor:"black"
                    colorItem:'white'
                }
                ListElement{
                    textColor:"black"
                    colorItem:'#1ac4bc'
                }
                ListElement{
                    textColor:"white"
                    colorItem:'#c912c0'
                }
                ListElement{
                    textColor:"white"
                    colorItem:"#18b823"
                }
                ListElement{
                    textColor:"white"
                    colorItem:"#f27507"
                }
                ListElement{
                    textColor:'white'
                    colorItem:"#7314e0"
                }
            }

            GridView{
                cellWidth: 25
                cellHeight: 35
                Layout.fillWidth: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                model: mod

                delegate: Item{
                    visible: true
                    Rectangle{
                        id:rect
                        width: 35
                        height: 35
                        radius: 35
                        color: colorItem
                        border.color: Material.foreground

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {

                                tituloField.color = textColor
                                notaField.color = textColor
                                rootBackground.color = colorItem;
                            }

                            onEntered: {
                                rect.y = rect.y - 10
                            }
                            onExited: {
                                rect.y = rect.y + 10
                            }
                        }
                    }
                }
            }

            Rectangle{
                id:anyColorItem
                width: 35
                height: 35
                radius: 35
                color: 'black'
                border.color: Material.foreground

                ToolButton {
                    anchors.fill: parent
                    icon.source: "icons/plus.png"
                    icon.color: '#fff'
                    onPressed: {
                        dialog.open();
                    }
                }

            }
        }



    }
}
