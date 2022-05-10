//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import Foundation
extension Date{
    func convertToMonthYearFormat() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyy"
        
        return dateFormater.string(from: self)
    }
}
