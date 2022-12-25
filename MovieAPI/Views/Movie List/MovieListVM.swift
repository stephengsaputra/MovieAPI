//
//  MovieListVM.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 24/12/22.
//

import Foundation

class MovieListVM {
    
    let service = Service.shared
    
    var movies: [Movie] = []
    var onFetchSucceed: (() -> Void)?
    
    func getMovieList(from endpoint: MovieListEndpoint, page: Int) {
        
        Service.shared.fetchMovies(from: endpoint, page: page) { [weak self] result in
            switch result {
                case .success(let success):
                    self?.movies.append(contentsOf: success.results)
                    self?.onFetchSucceed?()
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
