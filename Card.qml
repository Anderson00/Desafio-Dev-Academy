import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0

Item {
    id: cardItem
    property int elevation: 1
    property var cardColor: "#fafafa"
    property var borderColor: 'transparent'

    Rectangle {
        anchors.fill: parent
        color: cardColor
        border.color: borderColor
        radius: 4
        layer.enabled: cardItem.elevation > 0
        layer.effect: ElevationEffect {
            elevation: cardItem.elevation
        }
    }
}
