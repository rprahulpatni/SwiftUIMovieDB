//
//  MovieSearchViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine
import CoreData

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
    ///The prefix(_:) method allows us to take the first 5 elements of the fetched results array.
    @Published var recentSearches: Array<SearchedMovie> = Array<SearchedMovie>()
    /// A set to store Combine cancellables for API call subscriptions.
    private var cancellables = Set<AnyCancellable>()
    ///
    private let viewContext = PersistenceController.shared.container.viewContext
    
    /// The instance of the MovieSearchDataProvider.
    //    private let movieSearchDataProvider = MovieSearchDataProvider()
    private let movieSearchDataProvider : MovieSearchDataProvider
    
    init(dataProvider: MovieSearchDataProvider) {
        self.movieSearchDataProvider = dataProvider
    }
    
    // MARK: - Public Methods
    /// Fetch the seached movie list from the API based on specified search text.
    /// - Parameter showLoader: A boolean flag indicating whether to show a loading indicator during the API call.
    func getMovieList(_ showLoader: Bool, searchText: String) {
        self.isLoading = true
        // Call the MovieListDataProvider to fetch movie data from the API.
        self.movieSearchDataProvider.getMovieList(searchText)
        self.movieSearchDataProvider.arrMovieSearchData
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
    
    func getSearchedMovieFromCoreData() {
        viewContext.perform {
            let fetchRequest: NSFetchRequest<SearchedMovie> = SearchedMovie.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SearchedMovie.timestamp, ascending: false)]
            do {
                let allRecentSearches = try! self.viewContext.fetch(fetchRequest)
                self.recentSearches = Array(allRecentSearches.prefix(5))
            } catch {
                print("Error deleting existing movies: \(error)")
            }
        }
    }
    
    func saveSearchedMovieToCoreData(item: MovieSearchData) {
        do {
            self.getSearchedMovieFromCoreData()
            //Updating new searched movie details to viewContext
            let newSearch = SearchedMovie(context: viewContext)
            newSearch.timestamp = Date()
            newSearch.id = Int64(item.id ?? 0)
            newSearch.title = item.title
            newSearch.posterPath = item.posterPath
            
            // Optional: If you want to limit the number of recent searches to 5, remove the oldest one
            if recentSearches.count >= 5 {
                viewContext.delete(self.recentSearches.last!)
            }
            //Saving viewContext data to coredata
            try viewContext.save()
        } catch {
            // Handle the error
            print("Error saving search: \(error)")
        }
    }
}
