//
//  MovieDetailsViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var dictMovieDetails: MovieDetailsModel = MovieDetailsModel()
    @Published var arrMovieCastList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    @Published var arrMovieCrewList: Array<MovieCastNCrewData> = Array<MovieCastNCrewData>()
    @Published var arrReviewMovieList: Array<MovieReviewsData> = Array<MovieReviewsData>()
    @Published var arrSimilarMovieList: Array<MovieSimilarData> = Array<MovieSimilarData>()
    @Published var isLoading: Bool = false
    
    private var resources : MovieDetailsResources = MovieDetailsResources()
    
    func getMovieDetails(_ movieId: Int) {
        self.resources.getMovieDetails(movieId){ [weak self] result in
            switch result {
            case .success(let movieDetails):
                DispatchQueue.main.async {
                    self?.dictMovieDetails = movieDetails
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getMovieCastNCrew(_ movieId: Int) {
        self.resources.getMovieCastNCrew(movieId){ [weak self] result in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async {
                    self?.arrMovieCastList.append(contentsOf: movieList.cast)
                    self?.arrMovieCrewList.append(contentsOf: movieList.crew)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getMovieReviewDetails(_ movieId: Int) {
        self.resources.getMovieReviews(movieId){ [weak self] result in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async {
                    self?.arrReviewMovieList.append(contentsOf: movieList.results)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getMovieSimilarDetails(_ movieId: Int) {
        self.resources.getMovieSimilarMovies(movieId){ [weak self] result in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async {
                    self?.arrSimilarMovieList.append(contentsOf: movieList.results)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
