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
        
        currentPage = 1
        getList(pageNo: currentPage)
    }
    
    func loadMore() {        
        currentPage += 1
        getList(pageNo: currentPage)
    }
    
    private func getList(pageNo: Int) {
        
        view.showLoading(true)

        service.getList(pageNo: pageNo)
            .then {
                movieList in                
                self.view.showMore(movieList)
            }.always {
                self.view.showLoading(false)
            }.catch { error in
                self.view.showError(error.localizedDescription)
        }
    }
    
}
