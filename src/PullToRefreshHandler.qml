import QtQuick 2.11

Item
{
    id: pulltorefreshhandler

    property var flickable: parent
    property int threshold: 20
    readonly property alias is_pulldown: private_props.m_is_pulldown
    readonly property alias is_pullup: private_props.m_is_pullup

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

        onContentYChanged:
        {
            var changed_y_distance = Math.abs(private_props.y_flag - flickable.contentY);

            if(flickable.atYBeginning)
            {
                if(changed_y_distance > private_props.m_threshold)
                {
                    private_props.m_is_pulldown = true;
                    pulltorefreshhandler.pulldown();
                }

                if (private_props.m_is_pulldown && (flickable.contentY === flickable.originY))
                {
                    private_props.m_is_pulldown = false;
                    pulltorefreshhandler.pulldownrelease();
                }
            }

            if(flickable.atYEnd)
            {
                if(changed_y_distance > private_props.m_threshold)
                {
                    private_props.m_is_pullup = true;
                    pulltorefreshhandler.pullup();
                }

                if (private_props.m_is_pullup && (flickable.contentY === private_props.m_content_end))
                {
                    private_props.m_is_pullup = false;
                    pulltorefreshhandler.pulluprelease();
                }
            }
        }
    }

}
