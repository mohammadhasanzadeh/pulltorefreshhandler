import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2

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
                if (pulldown_handler.is_pulldown)
                    return "Release to add!";
                else if (pulldown_handler.is_pullup)
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
        indeterminate: (pulldown_handler.is_pulldown || pulldown_handler.is_pullup)
        visible: (pulldown_handler.is_pulldown || pulldown_handler.is_pullup)
    }

    ListView
    {
        anchors.top: progressbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: test_model
        clip: true
        delegate: ItemDelegate
        {
            text: model.text
            width: parent.width
        }

        PullToRefreshHandler
        {
            id: pulldown_handler
            property int counter: 3
            threshold: 20
            onPulldownrelease:
            {
                counter++;
                test_model.append({"text": "Item: " + counter})
            }

            onPulluprelease:
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
