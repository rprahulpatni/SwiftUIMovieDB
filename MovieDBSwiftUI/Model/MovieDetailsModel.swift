//
//  MovieDetailsModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

// MARK: - MovieDetailsModel
struct MovieDetailsModel: Decodable, Hashable {
    var id: Int?
    var backdropPath: String?
    var posterPath: String?
    var genres: [Genre]?
    var overview: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Decodable, Hashable {
    let id: Int?
    let name: String?
}

// MARK: - MovieCastNCrewModel
struct MovieCastNCrewModel: Decodable, Identifiable, Hashable {
    var id: Int?
    var cast, crew: [MovieCastNCrewData]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
}

// MARK: - Cast
struct MovieCastNCrewData: Hashable, Codable, Identifiable {
    var id: Int?
    var name, originalName: String?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

// MARK: - MovieReviews
struct MovieReviewsModel: Decodable, Identifiable, Hashable {
    var id, page: Int?
    var results: [MovieReviewsData]
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieReviewsData: Decodable, Hashable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content, createdAt, id, updatedAt: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Decodable, Hashable {
    var name, username, avatarPath: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
    }
}

// MARK: - Similar Movies
struct MovieSimilarModel: Decodable, Hashable {
    var page: Int?
    var results: [MovieSimilarData]
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieSimilarData
struct MovieSimilarData: Decodable, Identifiable, Hashable {
    var id: Int?
    var posterPath, releaseDate, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
    }
}
