import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt Dev.Academy")
    color: "#fafafa"

    RemoveFrutaDialog {
        id: removeFrutaDialog
        onAccepted: {
            frutas.removeFruta(fruta.index)
        }
    }

    AddFrutaDialog {
        id: addFrutaDialog
        onCancelPressed: {
            addFrutaDialog.clearFields()
            addFrutaDialog.close()
        }
        onOkPressed: {
            frutas.insertFruta(name, price, calories)
            addFrutaDialog.clearFields()
            addFrutaDialog.close()
        }
    }

    FrutaDatabaseModel {
        id: dbFrutas
    }

    FrutaListModel {
        id: frutas
        Component.onCompleted: {
            frutas.insertFruta("Tangerina", 5.55, 100)
        }
    }

    ListModel {
        id: carrinho
        function getTotal() {
            let total = 0;
            for(let i = 0; i < carrinho.rowCount(); i++) {
                total += carrinho.get(i).price
            }
            return total;
        }
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: `Carrinho do ${myModel.name}`
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            TextField {
                id: nameField
            }
            Button {
                text: "Salvar"
                enabled: nameField != ""
                onPressed: {
                    if(nameField != "") {
                        myModel.setName(nameField.text, myModel.id)
                    }
                }
            }
        }


        CarrinhoView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: carrinho
            onRemovePressed: {
                carrinho.remove(index)
                totalText.text = "Total: " + carrinho.getTotal()
            }
        }

        Text {
            id: totalText
            text: "Total: " + carrinho.getTotal()
            Layout.fillWidth: true
            font.pixelSize: 20
        }

        RowLayout {
            Text {
                text: "Produtos"
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            Button {
                text: "Novo"
                onPressed: {
                    addFrutaDialog.open()
                }
            }
        }

        FrutasView {
            Layout.fillHeight: true
            Layout.fillWidth: true
//            model: frutas
            model: dbFrutas
            onAddButtonPressed: {
                carrinho.append(fruta)
                totalText.text = "Total: " + carrinho.getTotal()
            }
            onRemoveButtonPressed: {
                removeFrutaDialog.fruta = fruta
                removeFrutaDialog.open()
            }
        }
    }
}
