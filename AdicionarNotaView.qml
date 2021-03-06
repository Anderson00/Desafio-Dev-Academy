import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0

import Models 1.0

Item {
    id: root


    property var stack
    property var notaTable
    property var marcadorTable
    property var idOfItem //se for undefined, inserção, se não, update
    property var markersListView
    property var markersModel
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
        if(idOfItem){
            tituloField.text = titulo;
            notaField.text = desc;
            rootBackground.color = cor;

            //Load marcadores
            console.log(idOfItem);
            var listOfMarkers = marcadorTable.getByNotaId(idOfItem);
            console.log('>>'+listOfMarkers.length)
            if(listOfMarkers.length > 0){
                markersModel.clear();
                for(var index in listOfMarkers){
                    markersModel.append({'boxChecked': true, 'nome':listOfMarkers[index]});
                }
                markersModel.append({'nome':''})
            }
        }else{
            markersModel.clear();
            markersModel.append({'nome':''});
        }
    }

    Component.onDestruction: {
        //Salva a nota ou mudanças
        var current = new Date();
        var data = current.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
        var hora = current.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);

        console.log(markersListView.count);

        //console.log(marcadorTable.)

        //Caso os campos não estejam preenchido, nada é salvo
        if(tituloField.text.trim().length > 0 || notaField.text.trim().length > 0){
            if(idOfItem === undefined){

                notaTable.newRow(tituloField.text, notaField.text, rootBackground.color,
                                 data+' '+ hora);

                dlist.currentIndex = 0;
                console.log('>>>> ' + markersListView.count)
                for(var i = 0; i < markersListView.count; i++){
                    let row = dlist.currentItem
                    let checkBox = row.children[0];
                    let textField = row.children[1];

                    console.log('>>>>>>>>>>>>>> '+textField.text+ ' '+checkBox.checked);

                    if(checkBox.checked){
                        marcadorTable.newRow(textField.text, notaTable.getNextId());
                    }

                    dlist.currentIndex = i + 1;
                }

            }else{
                //So atualiza a nota se houver alguma alteração, caso contrário, nada é feito
                // === quebra a logica
                if(!(tituloField.text == titulo && notaField.text == desc && rootBackground.color == cor)){
                    notaTable.updateRow(idOfItem, tituloField.text, notaField.text, rootBackground.color, data+' '+hora);
                }

            }
        }

        markersModel.clear();
        markersModel.append({'nome':''})

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
            font.pixelSize: 18
            font.bold: true
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
                cellWidth: 35
                cellHeight: 35
                Layout.fillWidth: true
                height: 35
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
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {

                                tituloField.color = textColor
                                notaField.color = textColor
                                rootBackground.color = colorItem;
                            }

                            onEntered: {
                                if(Qt.platform.os == 'android'){

                                }else{
                                    rect.y = rect.y - 10
                                }
                            }
                            onExited: {
                                if(Qt.platform.os == 'android'){

                                }else{
                                    rect.y = rect.y + 10
                                }
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

                }

                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onPressed: {
                        dialog.open();
                    }
                }

            }
        }



    }
}
