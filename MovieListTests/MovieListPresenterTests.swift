//
//  MovieListPresenterTests.swift
//  MovieListTests
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import XCTest
@testable import MovieList
import PromiseKit

class MovieListPresenterTests: XCTestCase {
    
    class MockMovieListView: MovieListViewProtocol {
        
        var showMoreCalled = false
        var showErrorCalled = false

        func showLoading(_ loading: Bool) {
        }
        
        func showError(_ message: String) {
            showErrorCalled = true
        }
        
        func showMore(_ data: [MovieSummary]?) {
            showMoreCalled = true
        }
    }
    
    class MockSuccessService: MovieServiceProtocol {
        
        func getList(pageNo: Int) -> Promise<[MovieSummary]?> {
            return Promise { fulfill, reject in
                let data = MovieList(JSONString: "{\"page\":1,\"results\":[{\"id\":252983,\"title\":\"Title 1\",\"popularity\":1.206096},{\"id\":325862,\"title\":\"Title 2\",\"popularity\":1.089258}],\"total_results\":281048,\"total_pages\":14053}")
                fulfill(data?.list)
            }
        }
        func getDetails(id: Int) -> Promise<MovieDetails> {
            return Promise { fullfill, reject in
            }
        }
    }
    
    class MockFailureService: MovieServiceProtocol {
        func getList(pageNo: Int) -> Promise<[MovieSummary]?> {
            return Promise { fulfill, reject in
                let err = NSError(domain: "MovieListTest", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request movie list data"])
                reject(err)
            }
        }
        func getDetails(id: Int) -> Promise<MovieDetails> {
            return Promise { fullfill, reject in
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessRequest() {
        let service = MockSuccessService()
        let view = MockMovieListView()
        
        let presenter = MovieListPresenter(service: service, view: view)
        presenter.refresh()
        wait(for: 1)
        XCTAssert(view.showMoreCalled)
        XCTAssert(!view.showErrorCalled)
        
        presenter.loadMore()
        wait(for: 1)
        XCTAssert(view.showMoreCalled)
        XCTAssert(!view.showErrorCalled)
    }
    
    func testFailureRequest() {
        let service = MockFailureService()
        let view = MockMovieListView()
        
        let presenter = MovieListPresenter(service: service, view: view)
        presenter.loadMore()
        wait(for: 1)
        XCTAssert(!view.showMoreCalled)
        XCTAssert(view.showErrorCalled)
    }
}
