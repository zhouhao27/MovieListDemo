//
//  MovieModelTests.swift
//  MovieList
//
//  Test model parsing functions
//
//  Created by Zhou Hao on 8/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import XCTest
@testable import MovieList
import ObjectMapper

class MovieModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieDetailsParsing() {
        let data = MovieDetails(JSONString:"{\"id\":1,\"title\":\"Test\",\"overview:\":\"This is the overview\"}")
        XCTAssert(data!.id == 1)
    }
    
    func testMovieListParsing() {
        let data = MovieList(JSONString: "{\"page\":1,\"results\":[{\"id\":252983,\"title\":\"Title 1\",\"popularity\":1.206096},{\"id\":325862,\"title\":\"Title 2\",\"popularity\":1.089258}],\"total_results\":281048,\"total_pages\":14053}")
        XCTAssert(data!.list?.count == 2)
    }
    
}
