//
//  YearMonth.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/20.
//

struct YearMonth: ComponentsGenerator {

    static func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType] {
        let minimumYear = config.calendar.component(.year, from: config.minimumDate)
        let maximumYear = config.calendar.component(.year, from: config.maximumDate)
        return [
            YearComponent(minimumYear: minimumYear, maximumYear: maximumYear),
            MonthComponent()
        ]
    }
}
