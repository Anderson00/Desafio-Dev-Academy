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
        console.log()
        toolbar.notaTable = notaDb;
    }

    property var window: this

    Material.theme: theme.checked ? Material.Dark : Material.Light

    header: MyToolbar{
        id:toolbar
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
        id:dialog
        modal: true
        anchors.centerIn: parent
        width: parent.width * 0.6
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
        RowLayout{
            anchors.fill: parent

            ToolButton{
                visible: false
                icon.source: "icons/magnify.png"
            }
        }

        ToolButton{
            id:fab
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
                stack.push('AdicionarNotaView.qml')
            }
        }
    }

    NotaDatabaseModel{
        id:notaDb
        onDataChanged: {
            console.log("wefwefwefwefwefwefwef");
        }
        onRowsInserted: {
            console.log("wefwefwefwefwefwefwef");
        }
    }

    StackView{
        id: stack
        anchors.fill: parent
        Layout.fillWidth: true

        initialItem: "HomeView.qml"


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
            if(stack.currentItem.isGrid !== undefined){
                stack.currentItem.toolbar = toolbar;
                toolbar.showActions();
                toolbar.showBackButton = false;
                fab.visible = true;
                bottomBar.visible = true;

                stack.currentItem.notaTable = notaDb;
                stack.currentItem.stack = stack;
            }
            else{
                toolbar.hideActions();
                fab.visible = false;
                bottomBar.visible = false;
                toolbar.showBackButton = true;
                stack.currentItem.notaTable = notaDb;
            }
        }
    }

}
