//
//  Month.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/20.
//

struct Month: ComponentsGenerator {

    static func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType] {
        return [MonthComponent()]
    }
}

