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
        listButtonAction: (iconBt)=>{
                              if(homeView.isGrid){
                                toolbar.iconList = 'icons/view-grid-outline.png'
                                homeView.isGrid = false
                              }else{
                                  toolbar.iconList = 'icons/format-list-bulleted-square.png'
                                  homeView.isGrid = true
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
        }
    }

    StackLayout{
        id: stack
        anchors.fill: parent
        Layout.fillWidth: true



        HomeView{
            id:homeView
        }

        AdicionarNotaView{

        }

    }

}
