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

//    private var resources : MovieDetailsResources = MovieDetailsResources()
    
//    func getMovieDetails(_ movieId: Int) {
//        self.resources.getMovieDetails(movieId){ [weak self] result in
//            switch result {
//            case .success(let movieDetails):
//                DispatchQueue.main.async {
//                    self?.dictMovieDetails = movieDetails
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
//
//    func getMovieCastNCrew(_ movieId: Int) {
//        self.resources.getMovieCastNCrew(movieId){ [weak self] result in
//            switch result {
//            case .success(let movieList):
//                DispatchQueue.main.async {
//                    self?.arrMovieCastList.append(contentsOf: movieList.cast)
//                    self?.arrMovieCrewList.append(contentsOf: movieList.crew)
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
//
//    func getMovieReviewDetails(_ movieId: Int) {
//        self.resources.getMovieReviews(movieId){ [weak self] result in
//            switch result {
//            case .success(let movieList):
//                DispatchQueue.main.async {
//                    self?.arrReviewMovieList.append(contentsOf: movieList.results)
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
//
//    func getMovieSimilarDetails(_ movieId: Int) {
//        self.resources.getMovieSimilarMovies(movieId){ [weak self] result in
//            switch result {
//            case .success(let movieList):
//                DispatchQueue.main.async {
//                    self?.arrSimilarMovieList.append(contentsOf: movieList.results)
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
    
    func getMovieDetails(_ movieId: Int) {
        self.isLoading = true
        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)?api_key=\(apikey)"
        NetworkManager.shared.callAPI(for: MovieDetailsModel.self, urlString: URL(string: strUrl)!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieDetails in
                self.dictMovieDetails = movieDetails
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getMovieCastNCrew(_ movieId: Int) {
        self.isLoading = true
        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/credits?api_key=\(apikey)"
        NetworkManager.shared.callAPI(for: MovieCastNCrewModel.self, urlString: URL(string: strUrl)!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrMovieCastList.append(contentsOf: movieList.cast)
                self.arrMovieCrewList.append(contentsOf: movieList.crew)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getMovieReviewDetails(_ movieId: Int) {
        self.isLoading = true
        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/reviews?api_key=\(apikey)"
        NetworkManager.shared.callAPI(for: MovieReviewsModel.self, urlString: URL(string: strUrl)!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
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
    
    func getMovieSimilarDetails(_ movieId: Int) {
        self.isLoading = true
        let strUrl = URLEndpoints.getMovieDetails + "\(movieId)/similar?api_key=\(apikey)"
        NetworkManager.shared.callAPI(for: MovieSimilarModel.self, urlString: URL(string: strUrl)!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrSimilarMovieList.append(contentsOf: movieList.results)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
