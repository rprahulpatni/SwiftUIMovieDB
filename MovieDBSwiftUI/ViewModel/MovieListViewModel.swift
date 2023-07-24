//
//  MovieListViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var arrMovieList: Array<MovieListData> = Array<MovieListData>()
    @Published var isLoading: Bool = false
    
    var totalPages: Int = 0
    var pageCount: Int = 1
    private var cancellables = Set<AnyCancellable>()
    
    //    func getMovieList(_ showLoader: Bool) {
    //        if showLoader {
    //            self.isLoading = true
    //        }
    //        self.resources.getMovieList(limit, skip) { [weak self] result in
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
    
    func getMovieList(_ showLoader: Bool) {
        if showLoader {
            self.isLoading = true
        }
        MovieListDataProvider.shared.getMovieList(pageCount)
        MovieListDataProvider.shared.arrMovieListData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrMovieList.append(contentsOf: movieList.results!.sorted(by: {$0.voteAverage! > $1.voteAverage!}))
                self.totalPages = movieList.totalPages ?? 0
                self.pageCount += 1
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
