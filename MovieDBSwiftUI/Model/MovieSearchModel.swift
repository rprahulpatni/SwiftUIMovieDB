//
//  MovieSearchModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 25/07/23.
//

import Foundation

// MARK: - MovieSearchModel
struct MovieSearchModel: Decodable, Hashable {
    var page: Int?
    var results: [MovieSearchData]
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieSearchData
struct MovieSearchData: Decodable, Identifiable, Hashable {
    var id: Int?
    var posterPath, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case title = "title"
    }
}
