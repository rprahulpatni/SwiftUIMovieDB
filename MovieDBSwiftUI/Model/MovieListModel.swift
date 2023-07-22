//
//  MovieListModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import CoreData


struct MovieListModel: Codable {
    var dates: MoviesDates
    var page: Int
    var results: [MovieListData]
    var totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct MoviesDates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct MovieListData: Codable {
    var adult: Bool
    var backdropPath: String
    var genreIDS: [Int]
    var id: Int
    var originalLanguage: OriginalLanguage
    var originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fi = "fi"
    case uk = "uk"
}

struct MovieSearchModel: Codable {
    var page: Int?
    var results: [MovieSearchData]
    var totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieSearchData: Codable {
    var id: Int?
    var posterPath, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case title = "title"
    }
}

// MARK: - Result
@objc(SearchedMovieData)
public class SearchedMovieData: NSManagedObject {
    @NSManaged public var timestamp: Date
    @NSManaged public var id: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
}
