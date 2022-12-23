//
//  MovieService.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 23/12/22.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchSingleMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

class Service: MovieService {
    
    static let shared = Service()
    private init() {}
    
    private let API_KEY = "48508f69298754c551be1467eb56afac"
    private let BASE_API_URL = "https://api.themoviedb.org/3"
    private let URL_SESSION = URLSession.shared
    private let JSON_DECODER = Utilities.JSON_DECODER
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(BASE_API_URL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchSingleMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(BASE_API_URL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(BASE_API_URL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: API_KEY)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        URL_SESSION.dataTask(with: finalURL) { [weak self] data, response, error in
            
            guard let self = self else { return }
        
            if error != nil {
                completion(.failure(.apiError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.JSON_DECODER.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }
        .resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
