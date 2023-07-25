//
//  MovieSearchViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

// MARK: - ViewModel
/// ViewModel responsible for managing data flow for the SwiftUI view.
class MovieSearchViewModel: ObservableObject {
    //MARK: - Properties
    /// A searchText is annotated with @Published, indicating that it is a published property.
    @Published var searchText: String = ""
    /// A flag indicating whether the ViewModel is currently loading data from the API.
    @Published var isLoading: Bool = false
    /// The array containing the list of movies.
    @Published var arrMovieList: Array<MovieSearchData> = Array<MovieSearchData>()
    /// A set to store Combine cancellables for API call subscriptions.
    private var cancellables = Set<AnyCancellable>()
    /// The instance of the MovieSearchDataProvider.
    private let movieSearchDataProvider = MovieSearchDataProvider()
    
    // MARK: - Public Methods
    /// Fetch the seached movie list from the API based on specified search text.
    /// - Parameter showLoader: A boolean flag indicating whether to show a loading indicator during the API call.
    func getMovieList(_ showLoader: Bool, searchText: String) {
        self.isLoading = true
        // Call the MovieListDataProvider to fetch movie data from the API.
        movieSearchDataProvider.getMovieList(searchText)
        movieSearchDataProvider.arrMovieSearchData
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                    //Stop loader as API provided error
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                // Process the received movieList and update the ViewModel's properties.
                self.arrMovieList.append(contentsOf: movieList.results)
                //Stop loader as API provided response
                self.isLoading = false
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
}
