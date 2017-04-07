//
//  MovieDetailsProtocol.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit

protocol MovieDetailsViewProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(_ message: String)
    func showDetails(_ data: MovieDetails)
    func goBooking(_ url: URL)
}

protocol MovieDetailsPresenterProtocol: class {
    func loadData()
    func booking()
}
