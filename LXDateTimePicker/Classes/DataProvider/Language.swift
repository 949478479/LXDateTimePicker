//
//  Language.swift
//  LXDateTimePicker
//
//  Created by 吕小怼 on 2019/5/15.
//

extension DateTimePicker {

    public enum Language {
        
        case chinese
        case english

        internal var dataProvider: DataProvider.Type {
            switch self {
            case .chinese:
                return ChineseDataProvider.self
            case .english:
                return EnglishDataProvider.self
            }
        }
    }
}
