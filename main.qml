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
            }

        }
    }

    footer: ToolBar{
        RowLayout{
            anchors.fill: parent

            ToolButton{
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
                stack.push('AdicionarNotaView.qml')
            }
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
                toolbar.showActions();
                toolbar.showBackButton = false;
            }
            else{
                toolbar.hideActions();
                toolbar.showBackButton = true;
            }
        }
    }

}
