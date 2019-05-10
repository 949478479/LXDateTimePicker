//
//  Configuration.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/17.
//

extension DateTimePicker {

    public class Configuration {

        /// 默认 `1970-01-01 00:00:00 +0000`
        public var minimumDate = Date(timeIntervalSince1970: 0)

        /// 默认 `2100-12-31 15:59:59 +0000`
        public var maximumDate = Date(timeIntervalSince1970: 4133951999)

        /// 默认 `.yearMonthDayHourMinute`
        public var mode = Mode.yearMonthDayHourMinute

        /// 默认 `Date()`
        public var date = Date()

        /// 默认 `Calendar.current`
        public var calendar = Calendar.current

        /// 默认 `false`
        public var use12HourClock = false

        /// 默认 `.chinese`
        public var language = Language.chinese

        init() {}
    }
}
