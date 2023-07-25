//
//  NetworkURL.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 24/07/23.
//

import Foundation
//Dummy URL
//    static let getMovieList = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apikey)&page="
//    static let getMovieDetails = "https://api.themoviedb.org/3/movie/"
//    static let getMovieDetailsCastNCrew = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(apikey)"
//    static let getMovieDetailsSimilar = "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(apikey)"
//    static let getMovieDetailsReviews = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(apikey)"
//    static let getMovieSearch = "https://api.themoviedb.org/3/search/movie?api_key=b91297e7a292736f0a74d685772b677e&query=C"

enum NetworkURL {
    case getMovieList(apiKey: String, pageCount: Int)
    case getMovieDetails(movieId: String, apiKey: String)
    case getMovieDetailsCastNCrew(movieId: String, apiKey: String)
    case getMovieDetailsSimilar(movieId: String, apiKey: String)
    case getMovieDetailsReviews(movieId: String, apiKey: String)
    case getMovieSearch(apiKey: String,  query: String)
}

extension NetworkURL {
    var url: URL?{
        switch self{
        case .getMovieList(let apiKey, let pageCount):
            let endPointPath = "\(URLEndpoints.MovieList)\(apiKey)&page=\(pageCount)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        case .getMovieDetails(let movieId, let apiKey):
            let endPointPath = "\(URLEndpoints.MovieDetails)\(movieId)?api_key=\(apiKey)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        case .getMovieDetailsCastNCrew(let movieId, let apiKey):
            let endPointPath = "\(URLEndpoints.MovieDetails)\(movieId)/credits?api_key=\(apiKey)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        case .getMovieDetailsSimilar(let movieId, let apiKey):
            let endPointPath = "\(URLEndpoints.MovieDetails)\(movieId)/similar?api_key=\(apiKey)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        case .getMovieDetailsReviews(let movieId, let apiKey):
            let endPointPath = "\(URLEndpoints.MovieDetails)\(movieId)/reviews?api_key=\(apiKey)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        case .getMovieSearch(let apiKey, let query):
            let endPointPath = "\(URLEndpoints.MovieSearch)\(apiKey)&query=\(query)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        }
    }
    
    static var baseURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/"
        guard let url = components.url else { return nil }
        return url
    }
    static var baseURLSting: String {
        return  NetworkURL.baseURL?.absoluteString ?? ""
    }
}
