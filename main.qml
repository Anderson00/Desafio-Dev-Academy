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

    Material.theme: theme.checked ? Material.Light : Material.Dark

    header: ToolBar{
        RowLayout{
            anchors.fill: parent
            ToolButton{
                icon.width: 20
                icon.source: "icons/view-grid-outline.png"
            }

            Label{
                id:title
                elide: Label.ElideRight
                Layout.fillWidth: true
                text: "User name"
            }

            ToolButton{
                id:lupa
                property var toggle: false

                icon.source: "icons/magnify.png"
                onClicked: {
                    search.visible = !search.visible
                }
            }

            TextField{
                id:search
                visible: false
                placeholderText: "Buscar"

                property var anim: anim
                property var anim2: anim2

                onFocusChanged: {
                    if(!focus){
                        search.visible = false
                    }
                }

                onVisibleChanged: {
                    if(visible){
                        anim.start()
                        search.focus = true
                    }
                }


                NumberAnimation on width{
                    id:anim
                    from:0
                    to:100
                    duration: 400
                }

            }

            ToolButton{
                icon.width: 20
                icon.source: "icons/view-grid-outline.png"
                onClicked: menu.open()
            }
        }
    }

    Item {
        anchors.right: parent.right
        Menu{
            id:menu
            Switch{
                id:theme
                text: "Dark mode"
                checked: false
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
    }

    StackLayout{
        id: stack
        anchors.fill: parent
    }

}
