import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0
import Models 1.0

Item {
    property var nameWindow: 'Identification'
    id:root
    anchors.fill: parent

    property var stack
    property var toolbar

    //signal identificationSuccess(string user, string email);

    function formValidation(){
        let hasErros = false;
        if(userField.text.trim().length == 0){
            //error msg
            userFieldError.text = 'Usuario vazio'
            hasErros = true;
        }else{
            //Limpa erro
            userFieldError.text = '';
        }

        if(emailField.text.trim().length == 0){
            //error msg
            emailFieldError.text = 'Email vazio'
            hasErros = true;
        }else{
            //Limpa erro
            emailFieldError.text = '';
        }

        return !hasErros;
    }

    Settings {
        id: settings
        property alias user: userField.text
        property alias email: emailField.text
        property alias lembrar: lembrarCheck.checked
    }

    Component.onCompleted: {
        if(settings.lembrar){
            userField.text = settings.user;
            emailField.text = settings.email;
            lembrarCheck.checked = settings.lembrar
        }else{
            userField.text = '';
            emailField.text = '';
        }
    }

    ColumnLayout{
        //anchors.fill: parent

        function calcWidth(){
            if(parent.width <= 350){
                return 250;
            }else {
                return 300;
            }
        }

        anchors.centerIn: parent
        width: calcWidth()
        ColumnLayout{
            //anchors.centerIn: parent


            spacing: 10



            ColumnLayout{
                Layout.fillWidth: true
                Layout.alignment: Layout.Center
                Image{
                    id:img

                    Layout.fillWidth: true
                    sourceSize.width: 60
                    sourceSize.height: 60
                    source: 'icons/icon-app.png'
                    fillMode: Image.PreserveAspectFit

                    smooth: true
                    visible: false
                }

                DropShadow{
                    anchors.fill:img
                    Layout.alignment: Layout.Center
                    horizontalOffset: 3
                    verticalOffset: 3
                    radius: 8.0
                    samples: 17
                    color: "#40000000"
                    source:img
                }
            }


            TextField{
                id:userField
                Layout.fillWidth: true
                placeholderText: 'Usuario'

                onTextEdited: {
                    userFieldError.text = ''
                }
            }
            Label{
                id:userFieldError
                color:'red'
                visible: userFieldError.text.trim().length > 0
                text: ''
            }

            TextField{
                id:emailField
                Layout.fillWidth: true
                placeholderText: 'Email'

                onTextEdited: {
                    emailFieldError.text = ''
                }
            }

            Label{
                id:emailFieldError
                color:'red'
                visible: emailFieldError.text.trim().length > 0
                text: ''
            }

            CheckBox{
                id:lembrarCheck
                checked: false
                font.pixelSize: 12
                text: 'Lembrar'
            }
        }
        Button{
            Layout.fillWidth: true
            text: 'Entrar'
            onPressed: {
                console.log(settings.email)
                if(formValidation()){

                    userModel.setNome(1, userField.text);
                    userModel.setEmail(1, emailField.text);

                    stack.push('HomeView.qml')
                }
            }
        }
    }
}
