//
//  MovieListViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine
//MARK: - ViewModel for MovieList
//ViewModel responsible for managing data flow for MovieList
class MovieListViewModel: ObservableObject {
    //MARK: - Properties
    /// The array containing the list of movies.
    @Published var arrMovieList: Array<MovieListData> = Array<MovieListData>()
    /// A flag indicating whether the ViewModel is currently loading data from the API.
    @Published var isLoading: Bool = false
    /// The total number of pages available from the API.
    var totalPages: Int = 0
    /// The current page count for API pagination.
    var pageCount: Int = 1
    /// A set to store Combine cancellables for API call subscriptions.
    private var cancellables = Set<AnyCancellable>()
    /// The instance of the MovieListDataProvider.
    private let movieListDataProvider = MovieListDataProvider()

    // MARK: - Public Methods
    /// Fetch the movie list from the API.
    /// - Parameter showLoader: A boolean flag indicating whether to show a loading indicator during the API call.
    func getMovieList(_ showLoader: Bool) {
        if showLoader {
            self.isLoading = true
        }
        // Call the MovieListDataProvider to fetch movie data from the API.
        movieListDataProvider.getMovieList(pageCount)
        movieListDataProvider.arrMovieListData
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
                self.arrMovieList.append(contentsOf: movieList.results!.sorted(by: {$0.voteAverage! > $1.voteAverage!}))
                //Updating totalpages from API response
                self.totalPages = movieList.totalPages ?? 0
                //Incrementing pagecount for pagination
                self.pageCount += 1
                //Stop loader as API provided response
                self.isLoading = false
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
}
