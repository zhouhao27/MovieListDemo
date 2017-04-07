//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import UIKit
import Cosmos
import RKTagsView

class MovieDetailsViewController: UIViewController {

    var presenter: MovieDetailsPresenter!
    
    @IBOutlet weak var posterImagerView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genresTagView: RKTagsView!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie Details"
        
        genresTagView.editable = false
        genresTagView.selectable = false
        genresTagView.font = UIFont.systemFont(ofSize: 14)
        presenter.loadData()
    }
    
    @IBAction func onBooking(_ sender: Any) {
        presenter.booking()
    }
    
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {

    func showLoading(_ loading: Bool) {
        
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        print(message)
    }
    
    func showDetails(_ data: MovieDetails) {
        
        // NOTICE: the popularity in discover is different form the one in move details. Probably it's a bug in server api!
        titleLable.text = data.title
        rateView.rating = data.rate ?? 0
        durationLabel.text = data.duration?.toTime()
        languageLabel.text = data.language ?? "-"
        overviewText.text = data.overview

        data.genres?.forEach {
            genresTagView.addTag($0.name ?? "-")
        }
        
        let placeholderImage = UIImage(named: "placeholder.jpg")!
        if let url = data.posterUrl() {
            posterImagerView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }

    func goBooking(_ url: URL) {
        UIApplication.shared.openURL(url)
    }
}
