//
//  PeriodComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class PeriodComponent: ComponentType {

    func numberOfRows() -> Int {
        return 2
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        return dataProvider.periodTitle(for: period(forRow: row))
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        switch dateComponents.period! {
        case .AM:
            return 0
        case .PM:
            return 1
        }
    }

    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.period
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        guard dateComponents.period != period(forRow: row) else {
            return nil
        }
        var temp = dateComponents
        temp.togglePeriod()
        return temp
    }
}

private extension PeriodComponent {

    func period(forRow row: Int) -> DateComponents.Period {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        return row == 0 ? .AM : .PM
    }
}
