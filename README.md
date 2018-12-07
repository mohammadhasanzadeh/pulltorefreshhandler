# PullToRefreshHandler
This QML component implements pull-to-refresh feature.

![](static/example_480.gif)

## Usage: 
Add the `PullToRefreshHandler.qml` file to your project and put PullToRefreshHandler component to your flickable element (e.g ListView):

```
    ListView
    {
        delegate: ItemDelegate
        {
            text: model.text
            width: parent.width
        }

        PullToRefreshHandler
        {
            onPulldownrelease:
            {
                // Youre code Here
            }

            onPulluprelease:
            {
                // Youre code Here
            }
        }
    }
```

### Signals:
+ signal `pulldown()`
+ signal `pullup()`
+ signal `pulldownrelease()`
+ signal `pulluprelease()`

### Properties:
+ `flickable`: var => Target flickable element, default is set to parent
+ `threshold`: int => The threshold of distance changes in the percentage of the parent height
+ `is_pulldown` (Readonly): bool
+ `is_pullup` (Readonly): bool 
