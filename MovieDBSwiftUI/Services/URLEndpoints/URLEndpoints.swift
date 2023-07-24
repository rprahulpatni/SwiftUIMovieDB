//
//  URLEndpoints.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

let apikey: String = "b91297e7a292736f0a74d685772b677e"
let imagePath : String = "https://image.tmdb.org/t/p/original"

enum URLEndpoints {
    static let MovieList = "movie/now_playing?api_key="
    static let MovieDetails = "movie/"
    static let MovieSearch = "search/movie?api_key="
}


