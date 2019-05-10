//
//  HourMinute.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/20.
//

struct HourMinute: ComponentsGenerator {

    static func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType] {
        let hourMinute: [ComponentType] = [
            HourComponent(use12HourClock: config.use12HourClock),
            MinuteComponent()
        ]

        if config.use12HourClock {
            return [PeriodComponent()] + hourMinute
        } else {
            return hourMinute
        }
    }
}
