//
//  Int+Time.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation

extension Int {
    
    private func format(f: String) -> String {
        return String(format: "%0\(f)d", self)
    }
    
    func toTime() -> String {
        
        if self == 0 {
            return "-"
        }
        
        var r = self
        let h = (r / 3600).format(f: "2")
        
        r %= 3600
        
        let m = (r / 60).format(f: "2")
        r %= 60
        
        let s = r.format(f: "2")
        
        return "\(h):\(m):\(s)"
    }
}
