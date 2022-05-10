//
//  string+Ext.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import Foundation
extension String {
    func convertToDate() -> Date? {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dataFormatter.locale = Locale(identifier: "en_US_POSIX")
        dataFormatter.timeZone = .current
        
        return dataFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
