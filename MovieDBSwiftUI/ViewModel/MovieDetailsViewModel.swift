//
//  MovieDetailsViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    @Published var dictMovieDetails: MovieDetailsModel = MovieDetailsModel()
    @Published var arrMovieCastList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    @Published var arrMovieCrewList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    @Published var arrReviewMovieList: Array<MovieReviewsData> = Array<MovieReviewsData>()
    @Published var arrSimilarMovieList: Array<MovieSimilarData> = Array<MovieSimilarData>()
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func getMovieDetails(_ movieId: Int) {
        self.isLoading = true
        MovieDetailsDataProvider.shared.getMovieDetails("\(movieId)")
        MovieDetailsDataProvider.shared.dictMovieDetails
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
//                    self.isLoading = false
                }
            }, receiveValue: { movieDetails in
                self.dictMovieDetails = movieDetails
//                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getMovieCastNCrew(_ movieId: Int) {
//        self.isLoading = true
        MovieDetailsDataProvider.shared.getMovieCastNCrewData("\(movieId)")
        MovieDetailsDataProvider.shared.arrMovieCastNCrewData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
//                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrMovieCastList.append(contentsOf: movieList.cast)
                self.arrMovieCrewList.append(contentsOf: movieList.crew)
//                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getMovieSimilarDetails(_ movieId: Int) {
//        self.isLoading = true
        MovieDetailsDataProvider.shared.getMovieSimilarData("\(movieId)")
        MovieDetailsDataProvider.shared.arrMovieSimilarData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
//                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrSimilarMovieList.append(contentsOf: movieList.results)
//                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getMovieReviewDetails(_ movieId: Int) {
//        self.isLoading = true
        MovieDetailsDataProvider.shared.getMovieReviewData("\(movieId)")
        MovieDetailsDataProvider.shared.arrMovieReviewData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrReviewMovieList.append(contentsOf: movieList.results)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
