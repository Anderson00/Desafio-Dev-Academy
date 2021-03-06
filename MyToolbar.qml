import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

ToolBar{
    id:root
    property var user
    property var email

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
                                  userInfo.visible = false
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
                                  userInfo.visible = true
                              }
    property var setBadgeMarkerValue: (value) =>{
                                          badgeMarkerText.text = value;
                                      }

    property var showBackButton: false

    signal textEdited(string text);
    signal markerButtonAction();
    signal deleteItemAction(int idOfItem);

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
            id:userInfo
            spacing: 0
            Label{
                id:title
                Layout.fillWidth: true
                elide: Label.ElideRight
                text: userModel.nome
                //text:user
                font.bold: true
            }
            Label{
                id:subTitle
                elide: Label.ElideRight
                text: userModel.email
                //text:email
                font.pixelSize: 12
            }

        }

        Label{
            id:dateTime
            visible: false
            text: date
            Layout.fillWidth: true
        }

        ToolButton{
            id:excluirItem
            visible: date !== undefined && date.length > 0 && dateTime.visible
            icon.source: "icons/delete.png"
            onClicked: {
                deleteItemAction(idOfItem);
            }
        }

        ToolButton{
            id:markers
            icon.source: "icons/tag.png"
            icon.width: 20
            onClicked: {
                root.markerButtonAction();
            }

            Rectangle{
                id:badgeMarker
                width: 16
                height: 16
                radius: 16
                color: Material.accent
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 6
                Text{
                    id:badgeMarkerText
                    anchors.centerIn: parent
                    font.pixelSize: 10
                    text: '5'
                }
            }
        }

        TextField{
            id:search
            Layout.fillWidth: true
            placeholderText: "Buscar"

            onFocusChanged: {

            }

            onVisibleChanged: {
                if(visible){
                    lupa.visible = false
                    lupaClose.visible = true
                }else{
                    lupaClose.visible = false;
                    lupa.visible = true;
                }
            }

            onTextChanged: {
                root.textEdited(text);
            }
        }

        ToolButton{
            id:lupa

            icon.source: "icons/magnify.png"
            onClicked: {
                if(Qt.platform.os == 'android'){
                    userInfo.visible = !userInfo.visible;
                }

                search.visible = !search.visible

            }


        }
        ToolButton{
            id:lupaClose
            visible: false

            icon.source: "icons/magnify-close.png"
            onClicked: {
                if(Qt.platform.os == 'android'){
                    userInfo.visible = !userInfo.visible;
                }

                search.visible = !search.visible
                search.text = ''
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
            onClicked: {
                menu.open();
            }
        }
    }
}
