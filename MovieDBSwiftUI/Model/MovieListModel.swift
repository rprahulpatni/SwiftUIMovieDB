//
//  MovieListModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import CoreData


struct MovieListModel: Decodable, Hashable {
    var dates: MoviesDates?
    var page: Int?
    var results: [MovieListData]?
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct MoviesDates: Decodable, Hashable {
    let maximum, minimum: String?
}

// MARK: - Result
struct MovieListData: Decodable, Identifiable, Hashable {
    var id: Int?
    var posterPath, releaseDate, title: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MovieSearchModel: Decodable, Hashable {
    var page: Int?
    var results: [MovieSearchData]?
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieSearchData: Decodable, Identifiable, Hashable {
    var id: Int?
    var posterPath, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case title = "title"
    }
}
