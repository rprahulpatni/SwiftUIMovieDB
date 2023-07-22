//
//  SearchMovieViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class SearchMovieViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var arrMovieList: Array<MovieSearchData> = Array<MovieSearchData>()
    private var cancellables = Set<AnyCancellable>()

//    private var resources : MovieSearchRecources = MovieSearchRecources()
    var totalPages: Int = 0
    var limit: Int = 0
    var skip: Int = 0
    
//    func getMovieList(_ showLoader: Bool, searchText: String) {
//        if showLoader {
//            self.isLoading = true
//        }
//        self.resources.getMovieList(searchText) { [weak self] result in
//            switch result {
//            case .success(let movieList):
//                DispatchQueue.main.async {
//                    self?.arrMovieList.append(contentsOf: movieList.results)
//                    self?.isLoading = false
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//                self?.isLoading = false
//            }
//        }
//    }
    
    func getMovieList(_ showLoader: Bool, searchText: String) {
        self.isLoading = true
        let strUrl = URLEndpoints.getMovieSearch + "\(searchText.trimmed)"
        NetworkManager.shared.callAPI(for: MovieSearchModel.self, urlString: URL(string: strUrl)!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrMovieList.append(contentsOf: movieList.results)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
