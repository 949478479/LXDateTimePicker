//
//  DateTimePicker.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/1/29.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

public class DateTimePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    public private(set) var dateComponents: DateComponents {
        didSet {
            guard dateComponents != oldValue else {
                return
            }

            var yearDidChange: Bool {
                return dateComponents.year != oldValue.year
            }

            var monthDidChange: Bool {
                return dateComponents.month != oldValue.month
            }

            if let dayComponent = dayComponent, yearDidChange || monthDidChange {
                let dayComponent = components[dayComponent] as! DayComponent
                dayComponent.year = dateComponents.year
                dayComponent.month = dateComponents.month
                reloadDayComponent()
            }
        }
    }

    /// 设置该属性没有效果
    public override var delegate: UIPickerViewDelegate? {
        get { return super.delegate }
        set { }
    }

    /// 设置该属性没有效果
    public override var dataSource: UIPickerViewDataSource? {
        get { return super.dataSource }
        set { }
    }
    
    private let mode: Mode

    private let minimumYear: Int

    private var maximumYear: Int

    private let calendar: Calendar

    private let use12HourClock: Bool

    private let language: Language

    private var dataProvider: DataProvider.Type {
        return language.dataProvider
    }

    private let dayComponent: Int?
    private let components: [ComponentType]

    private init(config: Configuration) {
        mode = config.mode
        calendar = config.calendar
        language = config.language
        use12HourClock = config.use12HourClock
        minimumYear = calendar.component(.year, from: config.minimumDate)
        maximumYear = calendar.component(.year, from: config.maximumDate)
        dateComponents = DateComponents(date: config.date, calendar: calendar, use12HourClock: use12HourClock)
        components = mode.components(config: config, dateComponents: dateComponents)

        if (config.mode == .yearMonthDay) || (config.mode == .yearMonthDayHourMinute) {
            dayComponent = 2
        } else {
            dayComponent = nil
        }

        super.init(frame: CGRect())

        super.dataSource = self
        super.delegate = self

        selectRow(for: dateComponents)
    }

    public convenience init(_ builder: (Configuration) -> Void = { _ in }) {
        let config = Configuration()
        builder(config)
        self.init(config: config)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PickerView
private extension DateTimePicker {

    func selectRow(for dateComponents: DateComponents) {
        components.enumerated().forEach {
            selectRow($1.row(forComponentIn: dateComponents), inComponent: $0, animated: false)
        }
    }

    func reloadDayComponent() {
        if let dayComponent = dayComponent {
            reloadComponent(dayComponent)
        }
    }
}

// MARK: - UIPickerViewDataSource
public extension DateTimePicker {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].numberOfRows()
    }
}

// MARK: - UIPickerViewDelegate
public extension DateTimePicker {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let dateComponents = components[component].updating(dateComponents, forSelectRow: row) {
            self.dateComponents = dateComponents
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let titleLabel = (view as? UILabel) ?? {
            let label = UILabel()
            label.textAlignment = .center
            label.minimumScaleFactor = 0.5
            label.adjustsFontSizeToFitWidth = true
            label.font = UIFont.systemFont(ofSize: 18)
            return label
        }()
        titleLabel.text = components[component].title(forRow: row, dataProvider: dataProvider)
        return titleLabel
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let viewWidth = pickerView.frame.width
        let widthInfo = dataProvider.widthInfo
        let totalComponentWidth = widthInfo.total
        let componentsCount = CGFloat(numberOfComponents(in: pickerView))
        let totalBuiltInPadding = (componentsCount - 1) * 5
        let padding = floor((viewWidth - totalComponentWidth - totalBuiltInPadding) / componentsCount)
        return components[component].width(with: widthInfo) + min(padding, 8)
    }
}
