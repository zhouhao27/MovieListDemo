//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Zhou Hao on 7/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    
    var movieListPresenter: MovieListPresenter!
    var movieService: MovieService!
    var movieList = [MovieSummary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        
        movieService = MovieService()
        movieListPresenter = MovieListPresenter(service: movieService, view: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func refresh() {
        movieListPresenter.refresh()
    }
    
    func onRefresh() {
        movieList = []
        refresh()
    }
    
    // MARK: scrollviewDelegate to calculate if need to load more
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        
        if(y > size.height + 15.0) {
            movieListPresenter.loadMore()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetails" {
            if let vc = segue.destination as? MovieDetailsViewController {
                let movieSummary = movieList[(tableView.indexPathForSelectedRow?.row)!]
                vc.presenter = MovieDetailsPresenter(service: movieService, view: vc, movieId: movieSummary.id!)
            }
        }
    }
}

// MARK: MovieListViewProtocol implementation
extension MovieListViewController: MovieListViewProtocol {
    
    func showLoading(_ loading: Bool) {
        if !loading {
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    func showError(_ message: String) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func showMore(_ data: [MovieSummary]?) {
        
        if let data = data {
            movieList += data
            tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource implementation
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movieSummary = movieList[indexPath.row]
        cell.titleLabel.text = movieSummary.title
        cell.rateView.rating = movieSummary.rate ?? 0
        
        showImage(imageUrl: movieSummary.posterUrl(), atImageView: cell.posterImageView)
        showImage(imageUrl: movieSummary.backDropUrl(), atImageView: cell.backdropImageView)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    private func showImage(imageUrl: URL?, atImageView imageView: UIImageView) {
        
        let placeholderImage = UIImage(named: "placeholder.jpg")!
        if let url = imageUrl {
            imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        } else {
            imageView.image = placeholderImage
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




