import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Dialog {
    id: removeFrutaDialog
    property var fruta
    standardButtons: Dialog.Ok | Dialog.Cancel
    title: `Remover a fruta ${fruta.nome}?`
    x: parent.width/2 - addFrutaDialog.width/2
    y: parent.height/2 - addFrutaDialog.height/2
}
