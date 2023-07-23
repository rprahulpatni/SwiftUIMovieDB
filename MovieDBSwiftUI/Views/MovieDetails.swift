//
//  MovieDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import CoreData

struct MovieDetails: View {
    var movieId: Int = 0
    //For Coredata
    var isFromSearch: Bool = false
    var movieSearchData: MovieSearchData?
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: SearchedMovie.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchedMovie.timestamp, ascending: false)],
        animation: .easeInOut(duration: 0.3)
    )
    private var allRecentSearches: FetchedResults<SearchedMovie>
    private var recentSearches: [SearchedMovie] {
        Array(allRecentSearches.prefix(5))
    }
    
    @ObservedObject private var viewModel : MovieDetailsViewModel = MovieDetailsViewModel()
    @State private var gridHLayout : [GridItem] = [GridItem()]
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    MovieDetailsViewCell(movieDetails: viewModel.dictMovieDetails)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Cast", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCastList)
                        .background(.white)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Crew", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList)
                        .background(.white)
                    MovieDetailsReviewCell(categoryName: "Reviews", movieId: self.movieId, movieReview: viewModel.arrReviewMovieList)
                        .background(.white)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Similar Results", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList)
                        .background(.white)
                }
            }
            .onAppear{
                viewModel.getMovieDetails(movieId)
                viewModel.getMovieCastNCrew(movieId)
                viewModel.getMovieSimilarDetails(movieId)
                viewModel.getMovieReviewDetails(movieId)
            }
            .onDisappear{
                if isFromSearch {
                    saveSearch(item: movieSearchData!)
                }
            }
            .navigationBarTitle("Movie Detail", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
        }
    }
    
    //     Function to save search text as a new SearchItem entity in Core Data
    private func saveSearch(item: MovieSearchData) {
        withAnimation {
            do {
                let newSearch = SearchedMovie(context: viewContext)
                newSearch.timestamp = Date()
                newSearch.id = Int64(item.id ?? 0)
                newSearch.title = item.title
                newSearch.posterPath = item.posterPath
                
                // Optional: If you want to limit the number of recent searches to 5, remove the oldest one
                if recentSearches.count >= 5 {
                    viewContext.delete(recentSearches.last!)
                }
                try viewContext.save()
            } catch {
                // Handle the error
                print("Error saving search: \(error)")
            }
        }
    }
}

