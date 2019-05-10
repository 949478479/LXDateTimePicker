//
//  DayComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class DayComponent: ComponentType {

    var year: Int
    var month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}

extension DayComponent {

    func numberOfRows() -> Int {
        return DateComponents.numberOfDays(inYear: year, month: month)
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        let day = self.day(forRow: row)
        assert(day >= 1 && day <= numberOfRows(), "⚠️ day \(day) is invalid")
        let weekDay = DateComponents.weekDay(forYear: year, month: month, day: day)
        assert(1...7 ~= weekDay, "⚠️ weekDay \(weekDay) is invalid")
        return dataProvider.dayTitle(forDay: day, weekDay: weekDay)
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        let day = dateComponents.day
        assert(day >= 1 && day <= numberOfRows(), "⚠️ day \(day) is invalid")
        return day - 1
    }
    
    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.day
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        let day = self.day(forRow: row)
        guard day != dateComponents.day else {
            return nil
        }
        var temp = dateComponents
        temp.day = day
        return temp
    }
}

private extension DayComponent {
    
    func day(forRow row: Int) -> Int {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        return row + 1
    }
}
