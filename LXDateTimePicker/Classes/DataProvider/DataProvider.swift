//
//  DataProvider.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/15.
//

protocol ComponentWidthInfo {
    static var year: CGFloat { get }
    static var month: CGFloat { get }
    static var day: CGFloat { get }
    static var period: CGFloat { get }
    static var hour: CGFloat { get }
    static var minute: CGFloat { get }
    static var total: CGFloat { get }
}

protocol DataProvider {
    static var widthInfo: ComponentWidthInfo.Type { get }

    static func yearTitle(forYear year: Int) -> String
    static func monthTitle(forMonth month: Int) -> String
    static func dayTitle(forDay day: Int, weekDay: Int) -> String
    static func hourTitle(forHour hour: Int) -> String
    static func minuteTitle(forMinute minute: Int) -> String
    static func periodTitle(for period: DateComponents.Period) -> String
}
