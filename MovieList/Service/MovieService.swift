//
//  MovieService.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class MovieService: MovieServiceProtocol {
    
    func getList(pageNo: Int) -> Promise<[MovieSummary]?> {
        
        // get current date
        let date = Date().string(withFormat: "yyyy-MM-dd")
        
        let url = "\(Api.baseUrl)\(Api.discoverRequest)?api_key=\(Api.key)&primary_release_date.lte=\(date)&sort_by=release_date.desc&page=\(pageNo)"
        
        return Promise { fulfill, reject in
            Alamofire.request(url).responseObject { (response: DataResponse<MovieList>) in
                if response.result.isSuccess {
                    if let movieList = response.result.value {
                        fulfill(movieList.list)
                    }
                } else {
                    let err = NSError(domain: "MovieListDemo", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request movie list data"])
                    reject(err)
                }
            }
        }
    }
    
    func getDetails(id: Int) -> Promise<MovieDetails> {
        let url = "\(Api.baseUrl)\(Api.movieRequest)/\(id)?api_key=\(Api.key)"
        
        return Promise { fulfill, reject in
            Alamofire.request(url).responseObject { (response: DataResponse<MovieDetails>) in
                if response.result.isSuccess {
                    if let details = response.result.value {
                        fulfill(details)
                    }
                } else {
                    let err = NSError(domain: "MovieListDemo", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request movie details data"])
                    reject(err)
                }
            }
        }
    }
}
