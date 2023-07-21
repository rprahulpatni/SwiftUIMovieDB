//
//  MovieListViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var arrMovieList: Array<MovieListData> = Array<MovieListData>()
    @Published var isLoading: Bool = false
    
    private var resources : MovieListResources = MovieListResources()
    var totalPages: Int = 0
    var limit: Int = 0
    var skip: Int = 0
    
    func getMovieList(_ showLoader: Bool) {
        if showLoader {
            self.isLoading = true
        }
        self.resources.getMovieList(limit, skip) { [weak self] result in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async {
                    self?.arrMovieList.append(contentsOf: movieList.results)
                    self?.isLoading = false
                }
            case .failure(let err):
                print(err.localizedDescription)
                self?.isLoading = false
            }
        }
    }
}
