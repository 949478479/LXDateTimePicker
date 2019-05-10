//
//  YearMonthDayHourMinute.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/20.
//

struct YearMonthDayHourMinute: ComponentsGenerator {

    static func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType] {
        let minimumYear = config.calendar.component(.year, from: config.minimumDate)
        let maximumYear = config.calendar.component(.year, from: config.maximumDate)

        let yearMonthDay: [ComponentType] = [
            YearComponent(minimumYear: minimumYear, maximumYear: maximumYear),
            MonthComponent(),
            DayComponent(year: dateComponents.year, month: dateComponents.month)
        ]

        let hourMinute: [ComponentType] = [
            HourComponent(use12HourClock: config.use12HourClock),
            MinuteComponent()
        ]

        if config.use12HourClock {
            return yearMonthDay + [PeriodComponent()] + hourMinute
        } else {
            return yearMonthDay + hourMinute
        }
    }
}
