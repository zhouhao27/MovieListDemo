//
//  MovieListProtocol.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit

protocol MovieListViewProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(_ message: String)
    func showRefresh(_ data: [MovieSummary]?)
    func showMore(_ data: [MovieSummary]?)
}

protocol MovieListPresenterProtocol: class {
    func refresh()
    func loadMore()
}

protocol MovieServiceProtocol: class {
    func getList(pageNo: Int) -> Promise<[MovieSummary]?>
    func getDetails(id: Int) -> Promise<MovieDetails>
}
