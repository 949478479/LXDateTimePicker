//
//  DateTimePicker+DateComponents.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/1/31.
//  Copyright © 2019 MeChat. All rights reserved.
//

import Foundation

public struct DateComponents: Equatable {

    public var date: Date {
        return Foundation.DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hourIn24HourClock(), minute: minute).date!
    }

    public internal(set) var year: Int {
        get {
            return _year
        }
        set {
            assert(newValue >= 1, "⚠️ year \(newValue) is invalid")

            guard _year != newValue else {
                return
            }

            _year = newValue

            let day = min(_day, DateComponents.numberOfDays(inYear: _year, month: _month))
            if day != _day {
                _day = day
            }

            weekDay = DateComponents.weekDay(forYear: _year, month: _month, day: _day)
        }
    }

    private var _year: Int

    /// 取值范围 1 ~ 12
    public internal(set) var month: Int {
        get {
            return _month
        }
        set {
            assert(newValue >= 1 && newValue <= 12, "⚠️ month \(newValue) is invalid")

            guard _month != newValue else {
                return
            }

            _month = newValue

            let maximumDay = DateComponents.numberOfDays(inYear: _year, month: _month)
            if maximumDay < _day {
                _day = maximumDay
            }

            let dateComponents = Foundation.DateComponents(calendar: calendar, year: _year, month: _month, day: _day)
            weekDay = calendar.dateComponents([.weekday], from: dateComponents.date!).weekday!
        }
    }

    private var _month: Int

    /// 取值范围 1 ~ 31
    public internal(set) var day: Int {
        get {
            return _day
        }
        set {
            assert(newValue >= 1 && newValue <= DateComponents.numberOfDays(inYear: _year, month: _month),
                   "⚠️ day \(newValue) is invalid")

            if _day != newValue {
                weekDay = weekDay(forDay: newValue) // 必须在设置 _day 之前计算星期
                _day = newValue
            }
        }
    }

    private var _day: Int

    /// 取值范围 1 ~ 7，1: 周日, 2: 周一, ..., 7: 周六
    public private(set) var weekDay: Int {
        get {
            return _weekDay
        }
        set {
            assert(newValue >= 1 && newValue <= 7, "⚠️ weekDay \(newValue) is invalid")

            if newValue != _weekDay {
                _weekDay = newValue
            }
        }
    }

    private var _weekDay: Int

    /// 取值范围 1 ~ 12（12小时制）或 0 ~ 23（24小时制）
    public internal(set) var hour: Int {
        get {
            return _hour
        }
        set {
            assert(use12HourClock ? (newValue >= 1 && newValue <= 12) : (newValue >= 0 && newValue <= 23),
                   "⚠️ hour \(newValue) is invalid")

            if newValue != _hour {
                _hour = newValue
            }
        }
    }

    private var _hour: Int

    /// 取值范围 0 ~ 59
    public internal(set) var minute: Int {
        get {
            return _minute
        }
        set {
            assert(newValue >= 0 && newValue <= 59, "⚠️ minute \(newValue) is invalid")

            if newValue != _minute {
                _minute = newValue
            }
        }
    }

    private var _minute: Int

    public private(set) var period: Period?

    private let calendar: Calendar

    private let use12HourClock: Bool

    init(date: Date, calendar: Calendar, use12HourClock: Bool = false) {
        self.calendar = calendar
        self.use12HourClock = use12HourClock

        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: date)

        _year = components.year!
        _month = components.month!
        _day = components.day!
        _weekDay = components.weekday!

        let hour = components.hour!
        if use12HourClock {
            _hour = (hour == 0 || hour == 12) ? 12 : hour % 12
            period = hour >= 12 ? .PM : .AM
        } else {
            _hour = hour
        }
        _minute = components.minute!
    }
}

// MARK: - 日期
extension DateComponents {

    static func numberOfDays(inYear year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            let isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
            return isLeapYear ? 29 : 28
        default:
            fatalError("⚠️ month \(month) is invalid")
        }
    }

    private func hourIn24HourClock() -> Int {
        switch period {
        case .AM?:
            return hour == 12 ? 0 : hour
        case .PM?:
            return hour == 12 ? hour : hour + 12
        default:
            return hour
        }
    }
}

// MARK: - 星期
extension DateComponents {

    func weekDay(forDay _day: Int) -> Int {
        assert(_day >= 1 && _day <= DateComponents.numberOfDays(inYear: year, month: month), "⚠️ day \(_day) is invalid")

        let offset = (_day - day) % 7
        guard offset != 0 else {
            return weekDay
        }

        let newWeekDay = weekDay + offset
        if newWeekDay < 1 {
            return newWeekDay + 7
        }
        if newWeekDay > 7 {
            return newWeekDay % 7
        }
        return newWeekDay
    }

    static func weekDay(forYear year: Int, month: Int, day: Int) -> Int {
        assert(year >= 1, "⚠️ year \(year) is invalid")
        assert(month >= 1 && month <= 12, "⚠️ month \(month) is invalid")
        assert(day >= 1 && day <= numberOfDays(inYear: year, month: month), "⚠️ day \(day) is invalid")

        let y, m: Int, d = day

        if month < 3 {
            m = month + 12
            y = year - 1
        } else {
            m = month
            y = year
        }

        let weekDay = (d + 1 + 2 * m + 3 * (m + 1) / 5 + y + y / 4 - y / 100 + y / 400) % 7 + 1

        assert(weekDay >= 1 && weekDay <= 7, "⚠️ weekDay \(weekDay) is invalid")

        return weekDay
    }
}

// MARK: - 上下午
extension DateComponents {

    public enum Period {
        case AM, PM
    }

    mutating func togglePeriod() {
        switch period! {
        case .AM:
            period = .PM
        case .PM:
            period = .AM
        }
    }
}
