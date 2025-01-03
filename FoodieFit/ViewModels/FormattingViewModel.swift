//
//  FormattingViewModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//
import Foundation

class Formatting {
    func date(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" 
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: dateString) else { return "" }

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func price(number: Float) -> String {
        return "$\(String(format: "%.2f", number))"
    }
}
