//
//  MovieSearchDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 22/07/23.
//

import Foundation
import Combine

// MARK: - MovieSearchDataProvider
/// Class responsible for providing searched movie list data from the API.
class MovieSearchDataProvider {
    //Set<AnyCancellable>(), is used to keep track of Combine's AnyCancellable objects.
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    /// Publisher that emits movie list data to its subscribers.
    var arrMovieSearchData = PassthroughSubject<MovieSearchModel, Never>()
    
    /// Fetches the movie list from the API for the specified page.
    /// - SearchText: The search text parameter is used for getting search results from API.
    func getMovieList(_ searchText: String) {
        //Encoding search text for URL
        guard let encodedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        // Create the URL for the API call using the NetworkURL helper function.
        let url = NetworkURL.getMovieSearch(apiKey: apikey, query: encodedString).url
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
                self.arrMovieSearchData.send(movieList)
            }).store(in: &self.cancellables)// Store the Combine cancellable for cleanup.
    }
    
    
}
