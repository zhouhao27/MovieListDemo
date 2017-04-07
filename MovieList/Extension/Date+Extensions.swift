//
//  Date+Extensions.swift
//  MovieList
//
//  Created by ZhouHao on 07/4/17.
//  Copyright (c) 2017 Zeus Software. All rights reserved.
//

import Foundation

extension Date {
    
    func string(withFormat format : String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    static func from(dateString date: String, withFormat format: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.date(from: date)!
    }

    // using current locale
    func string() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    static func from(dateString date: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.date(from: date)!
    }
    
}
