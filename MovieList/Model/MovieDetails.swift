//
//  MovieDetails.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import ObjectMapper

class Genre: Mappable {
    private static let keyId = "id"
    private static let keyName = "name"
    
    var id: String?
    var name: String?
    
    required init?(map: Map){
    }

    internal func mapping(map: Map) {
        id <- map[Genre.keyId]
        name <- map[Genre.keyName]
    }
}

class MovieDetails: Mappable {

    private static let keyId = "id"
    private static let keyTitle = "title"
    private static let keyRate = "popularity"
    private static let keyPosterPath = "poster_path"
    private static let keyOverview = "overview"
    private static let keyDuration = "runtime"
    private static let keyLanguage = "original_language"
    private static let keyGenres = "genres"
    
    var id: Int?
    var title: String?
    var rate: Double?
    var overview: String?
    var language: String?
    private var posterPath: String?
    var duration: Int?

    var genres: [Genre]?
    
    required init?(map: Map){
    }
    
    internal func mapping(map: Map) {
        id <- map[MovieDetails.keyId]
        title <- map[MovieDetails.keyTitle]
        rate <- map[MovieDetails.keyRate]
        posterPath <- map[MovieDetails.keyPosterPath]
        overview <- map[MovieDetails.keyOverview]
        duration <- map[MovieDetails.keyDuration]
        language <- map[MovieDetails.keyLanguage]
        genres <- map[MovieDetails.keyGenres]
    }
    
    func posterUrl() -> URL? {
        guard let path = posterPath else {
            return nil
        }
        
        let url = URL(string: "\(Api.imageBaseUrl)\(path)")
        return url
    }    
}
