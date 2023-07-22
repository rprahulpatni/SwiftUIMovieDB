//
//  MovieDetailsResources.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

//struct MovieDetailsResources {
//    func getMovieDetails(_ movieId: Int, completion: @escaping (Result<MovieDetailsModel>) -> Void) {
//        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)?api_key=\(apikey)"
//        NetworkManager.shared.callAPI(for: MovieDetailsModel.self, urlString: URL(string: strUrl)!, method: .get, completion: completion)
//    }
//    func getMovieSimilarMovies(_ movieId: Int, completion: @escaping (Result<MovieSimilarModel>) -> Void) {
//        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/similar?api_key=\(apikey)"
//        NetworkManager.shared.callAPI(for: MovieSimilarModel.self, urlString: URL(string: strUrl)!, method: .get, completion: completion)
//    }
//    func getMovieReviews(_ movieId: Int, completion: @escaping (Result<MovieReviewsModel>) -> Void) {
//        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/reviews?api_key=\(apikey)"
//        NetworkManager.shared.callAPI(for: MovieReviewsModel.self, urlString: URL(string: strUrl)!, method: .get, completion: completion)
//    }
//    func getMovieCastNCrew(_ movieId: Int, completion: @escaping (Result<MovieCastNCrewModel>) -> Void) {
//        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/credits?api_key=\(apikey)"
//        NetworkManager.shared.callAPI(for: MovieCastNCrewModel.self, urlString: URL(string: strUrl)!, method: .get, completion: completion)
//    }
//}
