//
//  MovieListDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

// MARK: - MovieListDataProvider
/// Class responsible for providing movie list data from the API.
class MovieListDataProvider {
    //Set<AnyCancellable>(), is used to keep track of Combine's AnyCancellable objects.
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    /// Publisher that emits movie list data to its subscribers.
    var arrMovieListData = PassthroughSubject<MovieListModel, Never>()
    
    /// Fetches the movie list from the API for the specified page.
    /// - Parameter pageCount: The page number for API pagination.
    func getMovieList(_ pageCount: Int) {
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieList(apiKey: apikey, pageCount: pageCount).url
        // Create a NetworkModel instance with the URL and HTTP method (GET in this case).
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { movieList in
                // Send the received movieList data to subscribers.
                self.arrMovieListData.send(movieList)
            }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
}
