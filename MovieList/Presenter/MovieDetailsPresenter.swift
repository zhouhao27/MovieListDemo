//
//  MovieDetailsPresenter.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    unowned fileprivate let service: MovieServiceProtocol
    unowned fileprivate var view: MovieDetailsViewProtocol
    private let id: Int
    
    required init(service: MovieServiceProtocol, view: MovieDetailsViewProtocol, movieId: Int) {
        self.service = service
        self.view = view
        self.id = movieId
    }
    
    func loadData() {
        view.showLoading(true)

        service.getDetails(id: id)
            .then { movieDetails in
                self.view.showDetails(movieDetails)
            }.always {
                self.view.showLoading(false)
            }.catch { error in
                print(error.localizedDescription)
        }
    }
    
    func booking() {
        view.goBooking(URL(string: "http://www.cathaycineplexes.com.sg/")!)
    }
}

