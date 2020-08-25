import QtQuick 2.14
import QtQuick.Controls 2.14

Item
{
    id: control
    width: hint_txt.contentWidth
    height: 50

    Image
    {
        id: swipe_up_img
        anchors.horizontalCenter: control.horizontalCenter
        y: 0
        sourceSize: "24x24"
        source: "qrc:/resources/images/icons_v2/up.svg"
    }

    Label
    {
        id: hint_txt
        anchors.bottom: parent.bottom
        text: "Swipe up to load more"
        anchors.horizontalCenter: control.horizontalCenter
        color: "gray"
    }

    SequentialAnimation
    {
        running: true
        loops: SequentialAnimation.Infinite
        PropertyAnimation
        {
            target: swipe_up_img
            property: "y"
            to: 10
            duration: 500
        }

        PropertyAnimation
        {
            target: swipe_up_img
            property: "y"
            to: 0
            duration: 500
        }
    }
}
