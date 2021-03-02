import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ListView {
    signal addButtonPressed(var fruta)
    signal removeButtonPressed(var fruta)
    clip: true
    spacing: 8
    delegate: Card {
        width: parent.width
        height: 64
        GridLayout {
            columnSpacing: 8
            columns: 5
            anchors.fill: parent
            anchors.margins: 8

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Nome"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Calorias"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Preço"
                    anchors.fill: parent
                }
            }

            Button {
                Layout.rowSpan: 2
                text: "+ Carrinho"
                onPressed: {
                    const fruta = {
                        name: model.name,
                        price: model.price
                    }
                    addButtonPressed(fruta)
                }
            }

            Button {
                Layout.rowSpan: 2
                text: "Remover"
                onPressed: {
                    const fruta = {
                        nome: model.name,
                        index: index
                    }
                    removeButtonPressed(fruta)
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.nome
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }


            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.calorias
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }


            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.preco
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }
        }
    }
}
