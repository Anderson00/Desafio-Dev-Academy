import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Item {
    id: root
    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        color: Material.background
    }

    ColumnLayout{
        width: parent.width
        height: parent.height



        spacing: 10

        TextField{
            id:tituloField

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            placeholderTextColor: Material.foreground
            Layout.fillWidth: true
            placeholderText: "Titulo"

            KeyNavigation.tab: notaArea
        }
        Flickable {
            id:flickable
            anchors.top: tituloField.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth:true
            flickableDirection: Flickable.VerticalFlick

            TextArea.flickable: TextArea {
                id: notaField
                placeholderTextColor: Material.foreground
                placeholderText: "Nota"
                wrapMode: TextArea.Wrap
            }

            ScrollBar.vertical: ScrollBar {
                visible: true
            }

        }
    }
}
