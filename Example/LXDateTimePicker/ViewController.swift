//
//  ViewController.swift
//  LXDateTimePicker
//
//  Created by 949478479 on 05/10/2019.
//  Copyright (c) 2019 949478479. All rights reserved.
//

import UIKit
import LXDateTimePicker

class ViewController: UIViewController {

    let picker = DateTimePicker { (config) in
        config.mode = .year
//        config.mode = .month
//        config.mode = .yearMonth
//        config.mode = .hourMinute
//        config.mode = .yearMonthDay
//        config.mode = .yearMonthDayHourMinute
//        config.use12HourClock = true
        config.language = .english
    }

    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm"
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 216).isActive = true
    }

    @IBAction func logDate() {
        let dateComponents = picker.dateComponents
        let date = dateComponents.date
        print(date, formatter.string(from: date))
        print(dateComponents)
        print()
    }
}
