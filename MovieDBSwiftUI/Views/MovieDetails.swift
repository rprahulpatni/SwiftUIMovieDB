//
//  MovieDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import CoreData

struct MovieDetails: View {
    @State var movieId: Int = 0
//    //For Coredata
//    var isFromSearch: Bool = false
//    var movieSearchData: MovieSearchData?
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: SearchedMovie.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \SearchedMovie.timestamp, ascending: false)],
//        animation: .easeInOut(duration: 0.3)
//    )
//    private var allRecentSearches: FetchedResults<SearchedMovie>
//    private var recentSearches: [SearchedMovie] {
//        Array(allRecentSearches.prefix(5))
//    }
    
    @ObservedObject var viewModel : MovieDetailsViewModel = MovieDetailsViewModel()
    @State private var gridHLayout : [GridItem] = [GridItem()]
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    MovieDetailsViewCell(movieDetails: viewModel.dictMovieDetails)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Cast", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCastList, onTab: { item in
                    })
                        .background(.white)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Crew", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList, onTab: { item in
                    })
                        .background(.white)
                    MovieDetailsReviewCell(categoryName: "Reviews", movieId: self.movieId, movieReview: viewModel.arrReviewMovieList)
                        .background(.white)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Similar Results", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList, onTab: { item in
                        self.movieId = item
                        self.viewModel.arrMovieCastList.removeAll()
                        self.viewModel.arrMovieCrewList.removeAll()
                        self.viewModel.arrSimilarMovieList.removeAll()
                        self.viewModel.arrReviewMovieList.removeAll()
                        self.callAPI()
                    })
                        .background(.white)
                }
            }
            .onAppear{
                self.callAPI()
            }
            .overlay{
                LoadingView(showProgress: $viewModel.isLoading)
            }
            .navigationBarTitle("Movie Detail", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
        }
    }
    
    private func callAPI() {
        viewModel.getMovieDetails(movieId)
        viewModel.getMovieCastNCrew(movieId)
        viewModel.getMovieSimilarDetails(movieId)
        viewModel.getMovieReviewDetails(movieId)
    }
}

