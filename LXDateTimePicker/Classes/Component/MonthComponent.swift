//
//  MonthComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class MonthComponent: ComponentType {

    func numberOfRows() -> Int {
        return 12
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        let month = self.month(forRow: row)
        assert(month >= 1 && month <= 12, "⚠️ month \(month) is invalid")
        return dataProvider.monthTitle(forMonth: month)
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        let month = dateComponents.month
        assert(month >= 1 && month <= 12, "⚠️ month \(month) is invalid")
        return month - 1
    }

    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.month
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        let month = self.month(forRow: row)
        guard month != dateComponents.month else {
            return nil
        }
        var temp = dateComponents
        temp.month = month
        return temp
    }
}

private extension MonthComponent {

    func month(forRow row: Int) -> Int {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        return row + 1
    }
}
