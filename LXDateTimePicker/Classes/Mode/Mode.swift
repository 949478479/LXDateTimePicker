//
//  ModeType.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/17.
//

extension DateTimePicker {

    public struct Mode: Equatable {
        
        public static let year = Mode(Year.self)
        public static let month = Mode(Month.self)
        public static let yearMonth = Mode(YearMonth.self)
        public static let hourMinute = Mode(HourMinute.self)
        public static let yearMonthDay = Mode(YearMonthDay.self)
        public static let yearMonthDayHourMinute = Mode(YearMonthDayHourMinute.self)

        public static func == (lhs: DateTimePicker.Mode, rhs: DateTimePicker.Mode) -> Bool {
            return lhs.generator == rhs.generator
        }

        func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType] {
            return generator.components(config: config, dateComponents: dateComponents)
        }

        private let generator: ComponentsGenerator.Type

        private init(_ generator: ComponentsGenerator.Type) {
            self.generator = generator
        }
    }
}

protocol ComponentsGenerator {
    static func components(config: DateTimePicker.Configuration, dateComponents: DateComponents) -> [ComponentType]
}
