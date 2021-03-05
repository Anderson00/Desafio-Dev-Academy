import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

ToolBar{
    id:root
    property var notaTable
    property var idOfItem
    property var menu
    property var date
    property var stack
    property var iconList: 'icons/format-list-bulleted-square.png'
    property var listButtonAction: (iconBt)=>{}
    property var hideActions: () => {
                                  lupa.visible = false;
                                  search.visible = false;
                                  iconBt.visible = false;
                                  dateTime.visible = true;
                                  markers.visible = true;
                              }
    property var showActions: () => {
                                  lupa.visible = true;
                                  if(search.text.trim().length > 0)
                                  search.visible = true;
                                  else
                                  search.visible = false;
                                  iconBt.visible = true;
                                  dateTime.visible = false;
                                  markers.visible = false
                              }
    property var showBackButton: false

    signal textEdited(string text);

    Component.onCompleted: {

    }

    RowLayout{
        anchors.fill: parent
        Rectangle{
            visible: !showBackButton
            width: 30
        }

        ToolButton{
            visible: showBackButton
            icon.width: 20
            icon.source: "icons/arrow-left.png"
            onPressed: {
                stack.pop();
            }
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

        Label{
            id:dateTime
            visible: false
            text: date
        }

        ToolButton{
            id:excluirItem
            visible: date !== undefined && date.length > 0 && dateTime.visible
            icon.source: "icons/delete.png"
            onClicked: {
                if(idOfItem !== undefined){
                    notaTable.deleteRow(idOfItem);
                    stack.pop();
                }
            }
        }

        ToolButton{
            id:markers
            icon.source: "icons/tag.png"
            icon.width: 20
            onClicked: {

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
            onTextChanged: {
                root.textEdited(text);
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
