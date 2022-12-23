//
//  ViewController.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 23/12/22.
//

import UIKit

class MovieListVC: UIViewController {

    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        Service.shared.fetchSingleMovie(id: 76600) { result in
            switch result {
                case .success(let success):
                    print(success.title)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
        
        Service.shared.fetchMovies(from: .nowPlaying) { result in
            switch result {
                case .success(let success):
                success.results.compactMap({ movie in
                    print(movie.title)
                })
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemGray3
    }
}

