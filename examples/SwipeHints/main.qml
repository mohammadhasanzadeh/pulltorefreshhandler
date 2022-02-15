import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import com.melije.pulltorefresh 2.0

ApplicationWindow
{
    id: main_window
    visible: true
    width: 360
    height: 520
    title: "PullToRefreshHandler"

    property var colors: ["#c2d6bd", "#c9e3e3", "#f2dac6", "#f0e2e2", "#f1f2f4"]

    header: ToolBar {
        Label
        {
            text: "PullToRefreshHandler Example"
            anchors.centerIn: parent
            color: "white"
        }
    }

    ListModel
    {
        id: test_model
        property int max_count: 15

        ListElement
        {
            text: "Item 1"
            color: "#c2d6bd"
        }

        ListElement
        {
            text: "Item: 2"
            color: "#c9e3e3"
        }

        ListElement
        {
            text: "Item: 3"
            color: "#f2dac6"
        }

        ListElement
        {
            text: "Item 4"
            color: "#f0e2e2"
        }

        ListElement
        {
            text: "Item: 5"
            color: "#f1f2f4"
        }
    }

    ListView
    {
        id: listview
        anchors.fill: parent
        model: test_model
        clip: true
        delegate: Rectangle
        {
            height: 100
            width: listview.width
            color: model.color
            radius: 7

            Label
            {
                anchors.centerIn: parent
                font.pointSize: 15
                text: model.text
            }
        }

        PullToRefreshHandler
        {
            id: pull_to_refresh_handler
            threshold: 30
            swipeUpHintDelegate: SwipeUpHint {}
            swipeUpHint.anchors.horizontalCenter: pull_to_refresh_handler.horizontalCenter
            swipeUpHint.active: test_model.count < test_model.max_count

            onPullUpRelease:
            {
                if (test_model.count < test_model.max_count)
                {
                    for (let counter = 0; counter < 5; counter++)
                    {
                        test_model.append({
                                              "text": `Item ${test_model.count+1}`,
                                              "color": main_window.colors[counter]
                                          });
                    }
                }
            }
        }
    }
}
