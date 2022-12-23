//
//  Utilities.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 23/12/22.
//

import Foundation

class Utilities {
    
    static let JSON_DECODER: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DATE_FORMATTER)
        return decoder
    }()
    
    static let DATE_FORMATTER: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "yyyy-mm-dd"
        return date
    }()
}
