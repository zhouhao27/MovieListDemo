//
//  MovieList.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieList: Mappable {

    private static let keyResults = "results"
    
    var list: [MovieSummary]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        list <- map[MovieList.keyResults]
    }

}
