//
//  MovieDetailsDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

// MARK: - MovieDetailsDataProvider
/// Class responsible for providing movie details data from the API.
class MovieDetailsDataProvider {
    //Set<AnyCancellable>(), is used to keep track of Combine's AnyCancellable objects.
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()

    // Publisher that emits movie list data to its subscribers.
    var dictMovieDetails = PassthroughSubject<MovieDetailsModel, Never>()
    var arrMovieCastNCrewData = PassthroughSubject<MovieCastNCrewModel, Never>()
    var arrMovieSimilarData = PassthroughSubject<MovieSimilarModel, Never>()
    var arrMovieReviewData = PassthroughSubject<MovieReviewsModel, Never>()
}
extension MovieDetailsDataProvider {
    /// Fetches the movie details from the API for the specified movieID.
    func getMovieDetails(_ movieId: String) {
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieDetails(movieId: movieId, apiKey: apikey).url
        // Create a NetworkModel instance with the URL and HTTP method (GET in this case).
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
        // Handle completion events (finished or error).
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
                // Handle API call failure.
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            // Send the received movieList data to subscribers.
            self.dictMovieDetails.send(movieList)
        }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetches the movie cast n crew from the API for the specified movieID.
    func getMovieCastNCrewData(_ movieId: String) {
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieDetailsCastNCrew(movieId: movieId, apiKey: apikey).url
        // Create a NetworkModel instance with the URL and HTTP method (GET in this case).
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
        // Handle completion events (finished or error).
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
                // Handle API call failure.
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            // Send the received movieList data to subscribers.
            self.arrMovieCastNCrewData.send(movieList)
        }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetches the movie similar to movie from the API for the specified movieID.
    func getMovieSimilarData(_ movieId: String) {
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieDetailsSimilar(movieId: movieId, apiKey: apikey).url
        // Create a NetworkModel instance with the URL and HTTP method (GET in this case).
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
        // Handle completion events (finished or error).
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
                // Handle API call failure.
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            // Send the received movieList data to subscribers.
            self.arrMovieSimilarData.send(movieList)
        }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetches the movie reviews from the API for the specified movieID.
    func getMovieReviewData(_ movieId: String) {
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieDetailsReviews(movieId: movieId, apiKey: apikey).url
        // Create a NetworkModel instance with the URL and HTTP method (GET in this case).
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
        // Handle completion events (finished or error).
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
                // Handle API call failure.
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            // Send the received movieList data to subscribers.
            self.arrMovieReviewData.send(movieList)
        }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
}
