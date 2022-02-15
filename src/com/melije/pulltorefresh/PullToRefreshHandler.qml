// Version: 2.0.0

import QtQuick 2.12

Item
{
    id: control
    anchors.fill: parent

    property Flickable target: parent
    property int threshold: 20
    readonly property alias isPullDown: private_props.m_is_pulldown
    readonly property alias isPullUp: private_props.m_is_pullup
    readonly property alias isPullingDown: private_props.m_is_pulling_down
    readonly property alias isPullingUp: private_props.m_is_pulling_up
    readonly property alias progress: private_props.m_progress
    property alias swipeUpHint: up_hint_loader
    property alias swipeDownHint: down_hint_loader
    property alias refreshIndicator: refresh_indicator_loader
    property int indicatorDragDirection: PullToRefreshHandler.TOPTOBOTTOM

    enum IndicatorDragDirection
    {
        TOPTOBOTTOM,
        BOTTOMTOTOP
    }

    // Delegates properties:
    property Component swipeUpHintDelegate: null
    property Component swipeDownHintDelegate: null
    property Component refreshIndicatorDelegate: RefreshIndicator {}

    QtObject
    {
        id: private_props
        property bool m_is_pulldown: false
        property bool m_is_pullup: false
        property bool m_is_pulling_down: false
        property bool m_is_pulling_up: false
        property int  m_threshold: (threshold * target.height) / 100
        property real m_progress: {
            if (!control.enabled)
                return 0;
            if (!control.target || !m_threshold)
                return 0;
            return (control.indicatorDragDirection === PullToRefreshHandler.TOPTOBOTTOM) ?
                        (control.target.verticalOvershoot * -100) / m_threshold : (control.target.verticalOvershoot * 100) / m_threshold;
        }
    }

    signal pullDown()
    signal pullUp()
    signal pullDownRelease()
    signal pullUpRelease()

    Connections
    {
        target: control.target
        enabled: control.enabled
        onVerticalOvershootChanged:
        {
            if (!control.target.verticalOvershoot)
            {
                private_props.m_is_pulling_down = false;
                private_props.m_is_pulling_up = false;
                if (private_props.m_is_pulldown)
                {
                    private_props.m_is_pulldown = false;
                    control.pullDownRelease();
                }
                if (private_props.m_is_pullup)
                {
                    private_props.m_is_pullup = false;
                    control.pullUpRelease();
                }
                return;
            }

            if (target.verticalOvershoot < 0)
            {
                private_props.m_is_pulling_down = true;
                if (Math.abs(control.target.verticalOvershoot) > private_props.m_threshold)
                {
                    private_props.m_is_pulldown = true;
                    control.pullDown();
                }
            }
            else if (control.target.verticalOvershoot > 0)
            {
                private_props.m_is_pulling_up = true;
                if (control.target.verticalOvershoot > private_props.m_threshold)
                {
                    private_props.m_is_pullup = true;
                    control.pullUp();
                }
            }
        }
    }

    Loader
    {
        id: up_hint_loader
        sourceComponent: (
                             control.enabled &&
                             control.swipeUpHintDelegate &&
                             control.target.contentHeight &&
                             control.target.atYEnd &&
                             !control.isPullUp
                             ) ? control.swipeUpHintDelegate : undefined
        anchors.bottom: parent.bottom
    }

    Loader
    {
        id: down_hint_loader
        sourceComponent: (
                             control.enabled &&
                             control.swipeDownHintDelegate &&
                             control.target.contentHeight &&
                             control.target.atYBeginning &&
                             !control.isPullDown
                             ) ? control.swipeDownHintDelegate : undefined
        anchors.bottom: parent.top
    }

    Loader
    {
        id: refresh_indicator_loader
        property real dragProgress: private_props.m_progress
        property PullToRefreshHandler handler: control
        sourceComponent: (
                             control.enabled &&
                             control.refreshIndicator.active &&
                             (private_props.m_progress > 0)
                             ) ?
                             control.refreshIndicatorDelegate : undefined
    }
}
