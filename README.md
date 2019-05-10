# LXDateTimePicker

[![CI Status](https://img.shields.io/travis/949478479/LXDateTimePicker.svg?style=flat)](https://travis-ci.org/949478479/LXDateTimePicker)
[![Version](https://img.shields.io/cocoapods/v/LXDateTimePicker.svg?style=flat)](https://cocoapods.org/pods/LXDateTimePicker)
[![License](https://img.shields.io/cocoapods/l/LXDateTimePicker.svg?style=flat)](https://cocoapods.org/pods/LXDateTimePicker)
[![Platform](https://img.shields.io/cocoapods/p/LXDateTimePicker.svg?style=flat)](https://cocoapods.org/pods/LXDateTimePicker)

支持【年】、【月】、【年月】、【年月日】、【时分】、【年月日时分】的日期选择器。

![](screenshot.png)

```
pod 'LXDateTimePicker'
```

```swift
import LXDateTimePicker

let picker = DateTimePicker { (config) in
    config.mode = .hourMinute
    config.use12HourClock = true
}

addSubview(picker)
```

```swift
let dateComponents = picker.dateComponents

print(dateComponents.date)
print(dateComponents.year)
print(dateComponents.month)
print(dateComponents.day)
print(dateComponents.weekDay)
print(dateComponents.hour)
print(dateComponents.minute)
print(dateComponents.period)
```