//
//  DateFormatterExtension.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 26.9.21..
//

import Foundation

extension DateFormatter {
    
    class func toString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/y"
        return formatter.string(from: date)
    }
    
    class func formatDate(value: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day]
        formatter.unitsStyle = .full
        
        let formattedString = formatter.string(from: TimeInterval(value))
        return formattedString!
    }
    
}
