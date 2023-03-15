# PullToRefreshHandler
ماژول QML برای استفاده ساده از قابلیت pull-to-refresh در Qt Quick.

## تغییرات ناسازگار:
توجه داشته باشید که در نسخه 2.0 تغییراتی انجام شد که در صورتی که می خواهید به نسخه 2.0 مهاجرت کنید، ممکن است نیار باشد که کد خود را بروز کنید:

```
- تمامی عناصر به ماژول com.melije.pulltorefresh منتقل شدند.
- برای سازگاری بهتر با QML قرارداد نام گذاری عناصر به camelCase تغییر کرد.
- خاصیت `flickable` در عنصر `PullToRefreshHandler` به `target` تغییر نام داده شد.
```

## تصاویر:

| ![](static/example_480.gif) |  ![](static/refresh_indicator.gif)   | ![](static/swip_up_hint.gif) |
| :-------------------------: | :----------------------------------: | :--------------------------: |
|          `Simple`           |         `Refresh indicator`          |         `Swipe up hint`      |

## پیش نیاز ها:
Qt >= 5.12

## روش نصب:
1. فایل `PullToRefreshHandler.pri` را به فایل پروژه (`.pro`) خود مانند زیر اضافه کنید:
```
include(Path/to/PullToRefreshHandler.pri)
```
2. دستور `engine.addImportPath("qrc:/");` را به فایل `main.cpp` قبل از عبارت `engine.load()` اضافه کنید.

## روش استفاده:
1. دستور `import com.melije.pulltorefresh 2.0` را به فایل `qml` خود اضافه کنید.

2. کامپوننت `PullToRefreshHandler` را به عنصر flickable دلخواه خود اضافه کنید (مانند ListView):

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
            onPullDownRelease:
            {
                // Add your handling code here:
            }

            onPullUpRelease:
            {
                // Add your handling code here:
            }
        }
    }
```

### Signals:
+ signal `pullDown()`
+ signal `pullUp()`
+ signal `pullDownRelease()`
+ signal `pullUpRelease()`

### Properties:
+ `target`: Flickable => Target flickable element, default is set to parent
+ `threshold`: int => The threshold of distance changes in the percentage of the parent height
+ `isPullDown` (Readonly): bool
+ `isPullUp` (Readonly): bool
+ `swipeUpHintDelegate`: Component => Any QML visual item to show when the flickable is scrolled to the end.
+ `swipeDownHintDelegate`: Component => Any QML visual item to show when the flickable is scrolled to the beginning.
+ `refreshIndicatorDelegate`: Component => Any QML Visual item to show when the flickable is scrolled to down or up, if you do not set this delegate, the default refresh indicator (Matrerial Refresh Indicator like) will show.
+ `indicatorDragDirection`: IndicatorDragDirection enum => `indicatorDragDirection` will specify when the `refreshIndicator` must be shown, the default value is `TOPTOBOTTOM`.

### IndicatorDragDirection enums:
|    Constant    |
| :------------: |
|  TOPTOBOTTOM   |
|  BOTTOMTOTOP   |

## Custom Refresh Indicator:
Any QML visual element can use as the refresh indicator, so you can easily create your custom refresh indicator.
When you set `refreshIndicatorDelegate` to your custom refresh indicator, `PullToRefreshHandler` will expose the `dragProgress` and `target` variables to your component so you can represent the progress using the values of these.

a simple example:
```
PullToRefreshHandler
{
    id: pulldown_handler
    threshold: 20
    refreshIndicatorDelegate: Rectangle {
        x: (pulldown_handler.width - width) / 2
        color: Qt.rgba(1, 0, 0, (dragProgress / 100))
        width: 24
        height: 24
        radius: width / 2
    }
}
```
For more complex implementation, please read the `src/com/melije/pulltorefresh/RefreshIndicator.qml`.

## Notes:
If you want to disable the refresh indicator you must change `refreshIndicator.active` to the false.

## Contribution:
Please help me to improve the quality of the project, contributions are welcome! :)
