//
//  SearchMovieViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
class SearchMovieViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
}
