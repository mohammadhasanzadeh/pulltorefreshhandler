import QtQuick 2.11

Item
{
    id: pulltorefreshhandler
    anchors.fill: parent

    property var flickable: parent
    property int threshold: 20
    readonly property alias is_pulldown: private_props.m_is_pulldown
    readonly property alias is_pullup: private_props.m_is_pullup
    // Swipe hints properties:
    property alias swipe_up_hint: up_hint_loader
    property alias swipe_down_hint: down_hint_loader
    property Component swipe_up_hint_delegate: null
    property Component swipe_down_hint_delegate: null

    QtObject
    {
        id: private_props
        property real m_content_end: (flickable.contentHeight > flickable.height) ?
                                         ((flickable.contentHeight + flickable.originY) - flickable.height) : flickable.originY;
        property int m_threshold: (threshold * flickable.height) / 100
        property real y_flag: 0
        property bool m_is_pulldown: false
        property bool m_is_pullup: false
    }

    signal pulldown()
    signal pullup()
    signal pulldownrelease()
    signal pulluprelease()

    Connections
    {
        target: flickable

        onAtYBeginningChanged:
        {
            if(flickable.atYBeginning)
                private_props.y_flag = flickable.contentY;
        }

        onAtYEndChanged:
        {
            if (flickable.atYEnd)
                private_props.y_flag = flickable.contentY;
        }

        onVerticalOvershootChanged:
        {
            if (!flickable.verticalOvershoot)
            {
                if (private_props.m_is_pullup)
                {
                    private_props.m_is_pullup = false;
                    pulltorefreshhandler.pulluprelease();
                }

                if (private_props.m_is_pulldown)
                {
                    private_props.m_is_pulldown = false;
                    pulltorefreshhandler.pulldownrelease();
                }
                return;
            }

            if (flickable.verticalOvershoot > 0)
            {
                if (flickable.verticalOvershoot > private_props.m_threshold)
                {
                    private_props.m_is_pullup = true;
                    pulltorefreshhandler.pullup();
                }
            }
            else if (flickable.verticalOvershoot < 0)
            {
                if (Math.abs(flickable.verticalOvershoot) > private_props.m_threshold)
                {
                    private_props.m_is_pulldown = true;
                    pulltorefreshhandler.pulldown();
                }
            }
        }
    }

    Loader
    {
        id: up_hint_loader
        sourceComponent: (
                             swipe_up_hint_delegate &&
                             flickable.contentHeight &&
                             flickable.atYEnd &&
                             !is_pullup
                           ) ? swipe_up_hint_delegate : undefined
        anchors.bottom: parent.bottom
    }

    Loader
    {
        id: down_hint_loader
        sourceComponent: (
                             swipe_down_hint_delegate &&
                             flickable.contentHeight &&
                             flickable.atYBeginning &&
                             !is_pulldown
                           ) ? swipe_down_hint_delegate : undefined
        anchors.bottom: parent.top
    }
}
