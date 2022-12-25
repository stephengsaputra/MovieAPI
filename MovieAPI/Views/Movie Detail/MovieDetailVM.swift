//
//  MovieDetailVM.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 24/12/22.
//

import Foundation

class MovieDetailVM {
    
    let service = Service.shared
    var movieTitle = ""
    
    var onFetchSucceed: (() -> Void)?
    
    func getSingleMovie(id: Int) {
        
        Service.shared.fetchSingleMovie(id: id) { [weak self] result in
            switch result {
                case .success(let success):
                    print(success.self)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
