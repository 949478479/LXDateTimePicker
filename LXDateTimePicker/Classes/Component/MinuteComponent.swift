//
//  MinuteComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class MinuteComponent: ComponentType {

    func numberOfRows() -> Int {
        return 60
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        let minute = self.minute(forRow: row)
        assert(minute >= 0 && minute <= 59, "⚠️ minute \(minute) is invalid")
        return dataProvider.minuteTitle(forMinute: minute)
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        let minute = dateComponents.minute
        assert(minute >= 0 && minute <= 59, "⚠️ minute \(minute) is invalid")
        return minute
    }
    
    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.minute
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        let minute = self.minute(forRow: row)
        guard minute != dateComponents.minute else {
            return nil
        }
        var temp = dateComponents
        temp.minute = minute
        return temp
    }
}

private extension MinuteComponent {

    func minute(forRow row: Int) -> Int {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        return row
    }
}
