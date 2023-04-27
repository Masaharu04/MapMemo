//
//  set_day.swift
//  lego_map
//
//  Created by Motoki on 2023/04/25.
//

/*-----------------------------------------------------------------------------
 --------日付を文字列型に変換する---------
 date_to_string(日付(Date)) -> 日付(String)
 ---------------------------------------------------------------------------*/

import Foundation
import UIKit

class DateUtils {
    class func dateToString(dateString: Date, format: String) -> String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: dateString)
    }

    class func stringToDate(dateString: String, fromFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = fromFormat
        return formatter.date(from: dateString)
    }
}

func date_to_string(date: Date) -> String{
    let string_date = DateUtils.dateToString(dateString: date, format: "yyyy-MM-dd HH:mm:ss Z")!
    return string_date
}
