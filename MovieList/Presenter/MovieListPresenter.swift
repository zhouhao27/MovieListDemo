//
//  MovieListPresenter.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit

class MovieListPresenter: MovieListPresenterProtocol {
    
    unowned fileprivate let service: MovieServiceProtocol
    unowned fileprivate var view: MovieListViewProtocol
    var currentPage: Int = 0
    
    required init(service: MovieServiceProtocol, view: MovieListViewProtocol) {
        self.service = service
        self.view = view
    }
    
    func refresh() {
        
        view.showLoading(true)
        currentPage = 1
        
        service.getList(pageNo: 1)
            .then { movieList in
                self.view.showRefresh(movieList)
            }.always {
                self.view.showLoading(false)
            }.catch { error in
                print(error.localizedDescription)
        }
    }
    
    func loadMore() {
        currentPage += 1
        
    }
    
}
