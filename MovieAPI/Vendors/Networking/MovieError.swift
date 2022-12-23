//
//  MovieError.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 23/12/22.
//

import Foundation

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
            case .apiError: return "Failed to fetch data!"
            case .invalidEndpoint: return "Invalid Endpoint!"
            case .invalidResponse: return "Invalid Response!"
            case .noData: return "No Data!"
            case .serializationError: return "Failed to Decode Data!"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
