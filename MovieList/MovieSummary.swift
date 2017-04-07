//
//  MovieSummary.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieSummary: Mappable {
    
    private static let keyId = "id"
    private static let keyTitle = "title"
    private static let keyRate = "popularity"
    private static let keyPosterPath = "poster_path"
    private static let keyBackDropPath = "backdrop_path"
    
    var id: Int?
    var title: String?
    var rate: Double?
    private var posterPath: String?
    private var backDropPath: String?
    
    required init?(map: Map){
    }
    
    internal func mapping(map: Map) {
        id <- map[MovieSummary.keyId]
        title <- map[MovieSummary.keyTitle]
        rate <- map[MovieSummary.keyRate]
        posterPath <- map[MovieSummary.keyPosterPath]
        backDropPath <- map[MovieSummary.keyBackDropPath]
    }
    
    func posterUrl() -> URL? {
        return urlForPath(path: posterPath)
    }
    
    func backDropUrl() -> URL? {
        return urlForPath(path: backDropPath)
    }
    
    private func urlForPath(path: String?) -> URL? {
        guard let path = posterPath else {
            return nil
        }
        
        let url = URL(string: "\(Api.imageBaseUrl)\(path)")
        return url
    }
    
}
