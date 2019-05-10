//
//  EnglishDataProvider.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/15.
//

struct EnglishDataProvider: DataProvider {

    static let widthInfo: ComponentWidthInfo.Type = WidthFactor.self
    
    static func yearTitle(forYear year: Int) -> String {
        return "\(year)"
    }

    static func monthTitle(forMonth month: Int) -> String {
        switch month {
        case  1: return "Jan"
        case  2: return "Feb"
        case  3: return "Mar"
        case  4: return "Apr"
        case  5: return "May"
        case  6: return "Jun"
        case  7: return "Jul"
        case  8: return "Aug"
        case  9: return "Sep"
        case 10: return "Oct"
        case 11: return "Nov"
        case 12: return "Dec"
        default:
            fatalError()
        }
    }

    static func dayTitle(forDay day: Int, weekDay: Int) -> String {
        let weekDayTitle: String = {
            switch weekDay {
            case 1:
                return "Sun"
            case 2:
                return "Mon"
            case 3:
                return "Tue"
            case 4:
                return "Wed"
            case 5:
                return "Thu"
            case 6:
                return "Fri"
            case 7:
                return "Sat"
            default:
                fatalError("⚠️ weekDay \(weekDay) is invalid")
            }
        }()
        return "\(day)" + " " + weekDayTitle
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
            return "AM"
        case .PM:
            return "PM"
        }
    }
}

private extension EnglishDataProvider {

    struct WidthFactor: ComponentWidthInfo {
        static let year: CGFloat = 45
        static let month: CGFloat = 34
        static let day: CGFloat = 64
        static let period: CGFloat = 27
        static let hour: CGFloat = 23
        static let minute: CGFloat = 23
        static let total: CGFloat = 216
    }
}
