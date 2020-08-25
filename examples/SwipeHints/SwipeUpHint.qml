import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Particles 2.14
import QtQuick.Controls.Material 2.14

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
        source: "qrc:/resources/up.svg"
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

    ParticleSystem
    {
        id: particle_system
    }

    Emitter
    {
        id: emitter
        anchors.centerIn: parent
        width: parent.width; height: parent.height
        system: particle_system
        emitRate: 5
        lifeSpan: 1000
        lifeSpanVariation: 500
        size: 2
        endSize: 6
        velocity: AngleDirection {
            angle: 270
            angleVariation: 10
            magnitude: 100
        }
    }

    ItemParticle
    {
        system: particle_system
        delegate: Rectangle {
           width: 4
           height: 4
           radius: width/2
           color: Material.accent
       }
    }
}
