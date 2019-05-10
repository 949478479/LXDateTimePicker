//
//  HourComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class HourComponent: ComponentType {

    private let use12HourClock: Bool

    init(use12HourClock: Bool) {
        self.use12HourClock = use12HourClock
    }
}

extension HourComponent {

    func numberOfRows() -> Int {
        return use12HourClock ? 12 : 24
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        let hour = self.hour(forRow: row)
        assert(use12HourClock ? (hour >= 1 && hour <= 12) : (hour >= 0 && hour <= 23), "⚠️ hour \(hour) is invalid")
        return dataProvider.hourTitle(forHour: hour)
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        let hour = dateComponents.hour
        assert(use12HourClock ? (hour >= 1 && hour <= 12) : (hour >= 0 && hour <= 23), "⚠️ hour \(hour) is invalid")
        return use12HourClock ? hour % 12 : hour
    }

    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.hour
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        let hour = self.hour(forRow: row)
        guard hour != dateComponents.hour else {
            return nil
        }
        var temp = dateComponents
        temp.hour = hour
        return temp
    }
}

private extension HourComponent {
    
    func hour(forRow row: Int) -> Int {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        if use12HourClock {
            return row == 0 ? 12 : row
        }
        return row
    }
}
