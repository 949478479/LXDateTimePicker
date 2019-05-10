//
//  YearComponent.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

class YearComponent: ComponentType {

    private let minimumYear: Int
    private let maximumYear: Int

    init(minimumYear: Int, maximumYear: Int) {
        self.minimumYear = minimumYear
        self.maximumYear = maximumYear
    }
}

extension YearComponent {

    func numberOfRows() -> Int {
        return maximumYear - minimumYear + 1
    }

    func row(forComponentIn dateComponents: DateComponents) -> Int {
        let year = dateComponents.year
        assert(year >= minimumYear && year <= maximumYear, "⚠️ year \(year) is invalid")
        return year - minimumYear
    }

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String {
        let year = self.year(forRow: row)
        assert(year >= 1, "⚠️ year \(year) is invalid")
        return dataProvider.yearTitle(forYear: year)
    }

    func width(with info: ComponentWidthInfo.Type) -> CGFloat {
        return info.year
    }

    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents? {
        let year = self.year(forRow: row)
        guard year != dateComponents.year else {
            return nil
        }
        var temp = dateComponents
        temp.year = year
        return temp
    }
}

private extension YearComponent {

    func year(forRow row: Int) -> Int {
        assert(row >= 0 && row < numberOfRows(), "⚠️ row \(row) is invalid")
        return minimumYear + row
    }
}
