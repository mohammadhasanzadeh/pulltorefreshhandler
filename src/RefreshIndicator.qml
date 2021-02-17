import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Shapes 1.12

Pane
{
    id: control
    width: 32
    height: 32
    padding: 0
    x: (flickable.width - width) / 2
    y: (handler_progress > 100) ? 100 : handler_progress
    Material.elevation: 2
    background: Rectangle {
        id: backgroud_rect
        color: Material.background
        radius: width / 2
        layer.enabled: control.enabled && control.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }
    }

    Shape
    {
        id: shape
        anchors.fill: parent
        asynchronous: true
        antialiasing: true
        smooth: true
        opacity: (handler_progress < 50) ? 0.5 : 1

        ShapePath
        {
            id: shape_path
            strokeWidth: 2
            strokeColor: "red"
            startX: 24
            startY: 16
            fillColor: "transparent"

            PathAngleArc
            {
                centerX: 16
                centerY: 16
                radiusX: 8
                radiusY: 8
                startAngle: -20
                sweepAngle: (handler_progress < 50) ? (handler_progress * 280) / 50 : 280
            }
        }

        rotation:
        {
             if (handler_progress >= 100)
                 return rotation;
             if (handler_progress >= 50 && handler_progress <= 100)
                return ((handler_progress - 50) * 200) / 50;
             return 0;
        }
    }
}
