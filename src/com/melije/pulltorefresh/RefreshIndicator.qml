import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15
import QtQuick.Shapes 1.15

Pane
{
    id: control
    width: 32
    height: 32
    padding: 0
    x: (handler.width - width) / 2
    y: dragProgress > 1 ? 100 : dragProgress * 100
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
        opacity: (dragProgress < 0.5) ? 0.5 : 1

        ShapePath
        {
            id: shape_path
            strokeWidth: 3
            strokeColor: control.Material.accent
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
                sweepAngle: dragProgress < 1 ? (dragProgress * 280) : 280
            }
        }

        rotation:
        {
            if (dragProgress >= 1)
                return rotation;
            if (dragProgress >= 0.5 && dragProgress <= 1)
               return ((dragProgress - 0.5) * 200);
            return 0;
        }
    }
}
