import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import com.melije.pulltorefresh 2.0

ApplicationWindow
{
    visible: true
    width: 360
    height: 520
    title: "PullToRefreshHandler"

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

        ListElement
        {
            text: "Item: 1"
        }

        ListElement
        {
            text: "Item: 2"
        }

        ListElement
        {
            text: "Item: 3"
        }
    }

    Label
    {
        id: help_lbl
        text: {
                if (pulldown_handler.isPullDown)
                    return "Release to add!";
                else if (pulldown_handler.isPullUp)
                    return "Release to remove!";
                else
                    "Pull down to add new item and pull up for remove item.";
        }
        anchors.top: parent.top
        width: parent.width
        fontSizeMode: Label.Fit
    }

    ProgressBar
    {
        id: progressbar
        anchors.top: help_lbl.bottom
        width: parent.width
        indeterminate: (pulldown_handler.isPullDown || pulldown_handler.isPullUp)
        visible: (pulldown_handler.isPullDown || pulldown_handler.isPullUp)
    }

    ListView
    {
        id: listview
        anchors.top: progressbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: test_model
        clip: true
        boundsMovement: ListView.StopAtBounds
        delegate: ItemDelegate
        {
            text: model.text
            width: listview.width
        }

        PullToRefreshHandler
        {
            id: pulldown_handler
            property int counter: 3
            threshold: 20
            onPullDownRelease:
            {
                counter++;
                test_model.append({"text": "Item: " + counter})
            }

            onPullUpRelease:
            {
                if (test_model.count)
                {
                    test_model.remove(test_model.count - 1);
                    counter--;
                }
            }
        }
    }
}
