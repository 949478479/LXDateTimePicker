//
//  ComponentType.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/16.
//

protocol ComponentType {

    func numberOfRows() -> Int

    func row(forComponentIn dateComponents: DateComponents) -> Int

    func title(forRow row: Int, dataProvider: DataProvider.Type) -> String

    func width(with info: ComponentWidthInfo.Type) -> CGFloat
    
    func updating(_ dateComponents: DateComponents, forSelectRow row: Int) -> DateComponents?
}
