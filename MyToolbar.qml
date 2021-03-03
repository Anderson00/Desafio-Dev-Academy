import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

ToolBar{
    property var menu
    property var iconList: 'icons/format-list-bulleted-square.png'
    property var listButtonAction: (iconBt)=>{}


    RowLayout{
        anchors.fill: parent
        ToolButton{
            icon.width: 20
            icon.source: "icons/view-grid-outline.png"
        }

        ColumnLayout{
            spacing: 0
            Label{
                id:title
                Layout.fillWidth: true
                elide: Label.ElideRight
                text: userModel.username
                font.bold: true
            }
            Label{
                id:subTitle
                elide: Label.ElideRight
                text: userModel.email
                font.pixelSize: 12
            }

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

            property var focusBlock: false
            property var anim: anim

            onFocusChanged: {
                if(search.text.trim().length > 0)
                    return
                if(!focus && search.visible){
                    search.visible = false
                }
            }

            onVisibleChanged: {
                if(visible){
                    anim.start()
                    focusBlock = true;
                    search.focus = true
                }else{
                    focusBlock = true;
                    search.focus = false;
                    search.visible = false

                    //focusBlock = false;
                }
            }


            NumberAnimation on width{
                id:anim
                from:0
                to:100
                duration: 400

                onStopped: {
                    search.focusBlock = false;
                }
            }

        }


        ToolButton{
            id:iconBt
            icon.width: 20
            icon.source: iconList
            onClicked: listButtonAction(iconBt)
        }
        ToolButton{
            icon.width: 20
            icon.source: "icons/dots-vertical.png"
            onClicked: menu.open()
        }
    }
}
