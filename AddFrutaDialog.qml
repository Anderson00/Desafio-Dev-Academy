import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Dialog {
    id: addFrutaDialog
    title: "Nova fruta"
    x: parent.width/2 - addFrutaDialog.width/2
    y: parent.height/2 - addFrutaDialog.height/2

    signal cancelPressed()
    signal okPressed(string name, double price, int calories)

    function clearFields() {
        nameField.clear()
        priceField.clear()
        calorieField.clear()
    }

    ColumnLayout {
        TextField{
            id: nameField
            placeholderText: "Nome"
        }
        TextField{
            id: calorieField
            placeholderText: "Calorias"
            validator: RegExpValidator { regExp: /[0-9]*/ }
        }
        TextField{
            id: priceField
            placeholderText: "Preço"
            validator: RegExpValidator { regExp: /[0-9]*.[0-9]{2}/ }
        }
        RowLayout {
            Button {
                text: "Cancelar"
                flat: true
                Material.foreground: "#C62828"
                onPressed: {
                    cancelPressed()
                }
            }
            Button {
                text: "Ok"
                flat: true
                Material.foreground: "#146d99"
                enabled: (!nameField.text == ""
                          && !priceField.text == ""
                          && !calorieField.text == ""
                          && priceField.text.split(".")[1] != "")

                onPressed: {
                    okPressed(nameField.text, Number(priceField.text), Number(calorieField.text))
                }
            }
        }
    }
}
