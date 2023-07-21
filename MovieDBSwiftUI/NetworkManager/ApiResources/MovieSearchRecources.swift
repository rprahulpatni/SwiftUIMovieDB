//
//  MovieSearchRecources.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 22/07/23.
//

import Foundation
struct MovieSearchRecources {
    func getMovieList(_ searchText: String, completion: @escaping (Result<MovieSearchModel>) -> Void) {
        let strUrl = URLEndpoints.getMovieSearch + "\(searchText.trimmed)"
        NetworkManager.shared.callAPI(for: MovieSearchModel.self, urlString: URL(string: strUrl)!, method: .get, completion: completion)
    }
}
