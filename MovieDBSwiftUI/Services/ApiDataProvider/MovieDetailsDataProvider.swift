//
//  MovieDetailsDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class MovieDetailsDataProvider {
    static let shared = MovieDetailsDataProvider()
    private var cancellables = Set<AnyCancellable>()
    // Subscribers
    var dictMovieDetails = PassthroughSubject<MovieDetailsModel, Never>()
    var arrMovieCastNCrewData = PassthroughSubject<MovieCastNCrewModel, Never>()
    var arrMovieSimilarData = PassthroughSubject<MovieSimilarModel, Never>()
    var arrMovieReviewData = PassthroughSubject<MovieReviewsModel, Never>()

    private init() {}
}
extension MovieDetailsDataProvider {
    func getMovieDetails(_ movieId: String) {
        let url = NetworkURL.getMovieDetails(movieId: movieId, apiKey: apikey).url
        let model = NetworkManager<MovieDetailsModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            self.dictMovieDetails.send(movieList)
        }).store(in: &self.cancellables)
    }
    
    func getMovieCastNCrewData(_ movieId: String) {
        let url = NetworkURL.getMovieDetailsCastNCrew(movieId: movieId, apiKey: apikey).url
        let model = NetworkManager<MovieCastNCrewModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            self.arrMovieCastNCrewData.send(movieList)
        }).store(in: &self.cancellables)
    }
    
    func getMovieSimilarData(_ movieId: String) {
        let url = NetworkURL.getMovieDetailsSimilar(movieId: movieId, apiKey: apikey).url
        let model = NetworkManager<MovieSimilarModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            self.arrMovieSimilarData.send(movieList)
        }).store(in: &self.cancellables)
    }
    
    func getMovieReviewData(_ movieId: String) {
        let url = NetworkURL.getMovieDetailsReviews(movieId: movieId, apiKey: apikey).url
        let model = NetworkManager<MovieReviewsModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            self.arrMovieReviewData.send(movieList)
        }).store(in: &self.cancellables)
    }
}
