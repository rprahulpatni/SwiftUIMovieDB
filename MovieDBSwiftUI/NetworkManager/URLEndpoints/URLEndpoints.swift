//
//  URLEndpoints.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

let apikey: String = "b91297e7a292736f0a74d685772b677e"
let imagePath : String = "https://image.tmdb.org/t/p/original"

struct URLEndpoints {
//    static let getMovieList = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apikey)")!
    static let getMovieList = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apikey)&page="
    static let getMovieDetails = "https://api.themoviedb.org/3/movie/"
    static let getMovieSearch = "https://api.themoviedb.org/3/search/movie?api_key=\(apikey)&query="
}
