//
//  MovieListVM.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 24/12/22.
//

import Foundation

protocol MovieListProtocol {
    
    var movies: [Movie] { get set }
    var onFetchSucceed: (() -> Void)? { get set }
    
    func getMovieList(from endpoint: MovieListEndpoint)
}

class MovieListVM: MovieListProtocol {
    
    let service = Service.shared
    
    var movies: [Movie] = []
    var onFetchSucceed: (() -> Void)?
    
    func getMovieList(from endpoint: MovieListEndpoint) {
        
        Service.shared.fetchMovies(from: endpoint) { [weak self] result in
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
