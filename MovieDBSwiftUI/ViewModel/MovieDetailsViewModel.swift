//
//  MovieDetailsViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

//MARK: - ViewModel for MovieDetails
//ViewModel responsible for managing data flow for MovieDetails
class MovieDetailsViewModel: ObservableObject {
    //MARK: - Properties
    /// The dictionary containing the details of movies.
    @Published var dictMovieDetails: MovieDetailsModel = MovieDetailsModel()
    /// The array containing the list of cast members of movie.
    @Published var arrMovieCastList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    /// The array containing the list of crew members of movie.
    @Published var arrMovieCrewList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    /// The array containing the list of movies reviews.
    @Published var arrReviewMovieList: Array<MovieReviewsData> = Array<MovieReviewsData>()
    /// The array containing the list of similiar movies.
    @Published var arrSimilarMovieList: Array<MovieSimilarData> = Array<MovieSimilarData>()
    /// A flag indicating whether the ViewModel is currently loading data from the API.
    @Published var isLoading: Bool = false
    /// A set to store Combine cancellables for API call subscriptions.
    private var cancellables = Set<AnyCancellable>()
    /// The instance of the MovieDetailsDataProvider.
    private let movieDetailsDataProvider = MovieDetailsDataProvider()

    // MARK: - Public Methods
    /// Fetch the movie details from the API based on specified movieID.
    func getMovieDetails(_ movieId: Int) {
        self.isLoading = true
        movieDetailsDataProvider.getMovieDetails("\(movieId)")
        movieDetailsDataProvider.dictMovieDetails
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }, receiveValue: { movieDetails in
                self.dictMovieDetails = movieDetails
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetch the movie cast n crew members list from the API based on specified movieID.
    func getMovieCastNCrew(_ movieId: Int) {
        movieDetailsDataProvider.getMovieCastNCrewData("\(movieId)")
        movieDetailsDataProvider.arrMovieCastNCrewData
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }, receiveValue: { movieList in
                self.arrMovieCastList.append(contentsOf: movieList.cast)
                self.arrMovieCrewList.append(contentsOf: movieList.crew)
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetch the movie similar list from the API based on specified movieID.
    func getMovieSimilarDetails(_ movieId: Int) {
        movieDetailsDataProvider.getMovieSimilarData("\(movieId)")
        movieDetailsDataProvider.arrMovieSimilarData
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }, receiveValue: { movieList in
                self.arrSimilarMovieList.append(contentsOf: movieList.results)
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
    
    /// Fetch the movie reviews list from the API based on specified movieID.
    func getMovieReviewDetails(_ movieId: Int) {
        movieDetailsDataProvider.getMovieReviewData("\(movieId)")
        movieDetailsDataProvider.arrMovieReviewData
        //The .sink operator is used to subscribe to a publisher and receive values emitted by the publisher.
            .sink(receiveCompletion: { completion in
                // Handle completion events (finished or error).
                switch completion {
                case .finished:
                    self.isLoading = false
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { movieList in
                self.arrReviewMovieList.append(contentsOf: movieList.results)
                self.isLoading = false
            })
            .store(in: &cancellables)// Store the Combine cancellable for cleanup.
    }
}
