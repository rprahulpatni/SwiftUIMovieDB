//
//  SearchMovieViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class SearchMovieViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var arrMovieList: Array<MovieSearchData> = Array<MovieSearchData>()
    
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
        MovieSearchDataProvider.shared.getMovieList(searchText)
        MovieSearchDataProvider.shared.arrMovieSearchData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrMovieList.append(contentsOf: movieList)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
