//
//  ChineseDataProvider.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/15.
//

struct ChineseDataProvider: DataProvider {

    static var widthInfo: ComponentWidthInfo.Type = WidthFactor.self

    static func yearTitle(forYear year: Int) -> String {
        return "\(year)年"
    }

    static func monthTitle(forMonth month: Int) -> String {
        return "\(month)月"
    }

    static func dayTitle(forDay day: Int, weekDay: Int) -> String {
        let weekDayTitle: String = {
            switch weekDay {
            case 1:
                return "周日"
            case 2:
                return "周一"
            case 3:
                return "周二"
            case 4:
                return "周三"
            case 5:
                return "周四"
            case 6:
                return "周五"
            case 7:
                return "周六"
            default:
                fatalError("⚠️ weekDay \(weekDay) is invalid")
            }
        }()
        return "\(day)日" + " " + weekDayTitle
    }

    static func hourTitle(forHour hour: Int) -> String {
        return "\(hour)"
    }

    static func minuteTitle(forMinute minute: Int) -> String {
        return String(format: "%02i", minute)
    }

    static func periodTitle(for period: DateComponents.Period) -> String {
        switch period {
        case .AM:
            return "上午"
        case .PM:
            return "下午"
        }
    }
}

private extension ChineseDataProvider {

    struct WidthFactor: ComponentWidthInfo {
        static let year: CGFloat = 63
        static let month: CGFloat = 41
        static let day: CGFloat = 82
        static let period: CGFloat = 37
        static let hour: CGFloat = 23
        static let minute: CGFloat = 23
        static let total: CGFloat = 269
    }
}
