import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true

    Component.onCompleted: {
        toolbar.notaTable = notaDb;
        stack.push("IdentificationView.qml", {'stack':stack,'toolbar':toolbar});
    }

    property var window: this
    property var idToRemove

    Material.theme: theme.checked ? Material.Dark : Material.Light

    header: MyToolbar{
        id:toolbar
        visible: false
        menu: menu
        stack: stack
        listButtonAction: (iconBt)=>{
                              if(stack.currentItem.isGrid !== undefined){
                                  if(stack.currentItem.isGrid){
                                      toolbar.iconList = 'icons/view-grid-outline.png'
                                      stack.currentItem.isGrid = false
                                  }else{
                                      toolbar.iconList = 'icons/format-list-bulleted-square.png'
                                      stack.currentItem.isGrid = true
                                  }
                              }
                          }


        onTextEdited: {
            addMarker('s');
            if(stack.currentItem.isGrid !== undefined){
                stack.currentItem.filter = text;
            }
        }

        onMarkerButtonAction: {
            markersDialog.open()
        }

        onDeleteItemAction: {
            excluirDialog.open()
            idToRemove = idOfItem;
        }
    }

    function addMarker(value){
        listModel.append({'nome':value});
        console.log(listModel.count)
    }

    Item {
        anchors.right: parent.right
        Menu{
            id:menu
            MenuItem{

                Switch{
                    id:theme
                    anchors.fill: parent
                    text: "Dark mode"
                    checked: true
                }
            }


            MenuItem{
                text: "help"
                onPressed: {
                    dialog.open();
                }
            }

        }
    }

    Dialog{
        id:excluirDialog
        modal:true
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.6
        title: 'Excluir?'

        standardButtons: Dialog.No | Dialog.Yes

        Label{
            anchors.centerIn: parent
            text: 'Tem certeza que deseja excluir a nota?'
            wrapMode: "WordWrap"
        }

        onRejected: {
            //close
        }

        onAccepted: {
            if(idToRemove !== undefined){
                notaDb.deleteRow(idToRemove);
                stack.pop();
            }
        }
    }

    Dialog{
        id:markersDialog
        modal:true
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.8
        title: 'Adicionar marcador'

        standardButtons: Dialog.Ok

        ColumnLayout{
            anchors.fill: parent

            ListView{
                id:dlist
                Layout.fillWidth: true
                Layout.fillHeight: true

                ScrollBar.vertical: ScrollBar {
                    visible: true
                }

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 500 }
                    NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 550 }
                }

                remove: Transition {
                    NumberAnimation { property: "x"; to: 50; duration: 200 }
                    NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 200 }
                }

                model: ListModel{
                    id:listModel

                    onRowsInserted: {
                        toolbar.setBadgeMarkerValue(listModel.count - 1);
                    }

                    onRowsRemoved: {
                        toolbar.setBadgeMarkerValue(listModel.count - 1);
                    }

                    ListElement{
                        idd: ''
                        boxChecked: true
                        nome: 'Front'
                    }
                }


                delegate: RowLayout{
                    property var currentIndex: listModel.cout - 1
                    width: parent.width
                    Text {
                        visible: false
                        text: idd || ''
                    }
                    CheckBox{
                        id:box
                        enabled: false
                        checked: boxChecked
                    }
                    TextField{
                        id:marcadorField
                        focus: true
                        Layout.fillWidth: true
                        placeholderText: 'Marcador'
                        text: nome

                        function addNewLine(){
                            if(marcadorField.text.trim().length > 0){
                                box.checked = true
                                box.enabled = true
                                marcadorField.focus = false;
                                listModel.append({'nome':''});
                                marcadorDelete.enabled = true
                                dlist.currentIndex = dlist.count - 1
                                dlist.currentItem.children[1].focus = true
                            }
                        }

                        Keys.onTabPressed: {
                            addNewLine();
                        }

                        onAccepted: {
                            addNewLine();

                        }
                    }

                    ToolButton{
                        id:marcadorDelete
                        enabled: nome.trim().length > 0
                        icon.source: 'icons/delete.png'
                        onPressed: {
                            listModel.remove(currentIndex)
                        }
                    }

                }

            }
        }
    }

    Dialog{
        id:dialog
        modal: true
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height
        title:'Help'
        standardButtons: Dialog.Ok


        Label{
            wrapMode: "Wrap"
            anchors.fill: parent
            text: 'O objetivo deste desafio é criar um clone do Google Keep.\nEste app suporta, inserção, atualização, busca e exclusão de notas. As notas podem ser visualizadas na forma de lista, ou grade, apertando o botão com ícone de grade ou lista na toolbar.\nTambém é possível alternar entre Modo Dark e Light.\nO Grid e a lista se adaptam a tela, o Grid aumenta o número de colunas com base no tamanho do monitor (responsivo). A data de alteração e ou inserção é registrada somente se dados forem alterados, evitando que notas totalmente vazias sejam armazenadas no Banco de dados. O banco de dados utiliza relacionamento simples, que relaciona a tabela User, com a tabela Notas.'
        }

        onAccepted: {

        }
    }

    footer: ToolBar{
        id:bottomBar
        visible: false
        RowLayout{
            anchors.fill: parent
            visible: false
            ToolButton{
                visible: false
                icon.source: "icons/magnify.png"
            }
        }

        ToolButton{
            id:fab
            visible: false
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 15
            icon.source: "icons/plus.png"
            Rectangle{
                radius:parent.width
                anchors.fill: parent
                color: Material.background
                border.color: Material.primary
                z:-1
            }

            onPressed: {
                toolbar.date = ''
                stack.push('AdicionarNotaView.qml',{"stack":stack, "markersModel":listModel,"markersListView": dlist})
            }
        }
    }

    NotaDatabaseModel{
        id:notaDb
    }

    MarcadorDatabaseModel{
        id:marcadorDb
    }


    StackView{
        id: stack
        visible: true
        focus:true
        anchors.fill: parent
        Layout.fillWidth: true


        Keys.onBackPressed: {
            event.accepted = stack.depth > 0
            pop();

        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200

            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        onCurrentItemChanged: {
            console.log(stack.currentItem.nameWindow)
            if(stack.currentItem.nameWindow == 'Home'){
                stack.currentItem.toolbar = toolbar;
                toolbar.showActions();
                toolbar.showBackButton = false;
                fab.visible = true;
                toolbar.visible = true;
                bottomBar.visible = true;

                stack.currentItem.notaTable = notaDb;
                stack.currentItem.marcadorTable = marcadorDb;
                stack.currentItem.stack = stack;
                stack.currentItem.markersListView = dlist
                stack.currentItem.markersModel = listModel
            }
            else if(stack.currentItem.nameWindow == 'AdicionarNota'){
                toolbar.hideActions();
                fab.visible = false;
                bottomBar.visible = false;
                toolbar.showBackButton = true;
                stack.currentItem.notaTable = notaDb;
                stack.currentItem.marcadorTable = marcadorDb;
                stack.currentItem.markersListView = dlist
                stack.currentItem.markersModel = listModel
            }
        }
    }

}
