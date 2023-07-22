//
//  MovieDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

struct MovieDetails: View {
    var movieId: Int = 0
    @ObservedObject private var viewModel : MovieDetailsViewModel = MovieDetailsViewModel()
    @State private var gridHLayout : [GridItem] = [GridItem()]
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.5)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    MovieDetailsViewCell(movieDetails: viewModel.dictMovieDetails)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Cast", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCastList)
                        .background(.white)
                    MovieDetailsSectionWithGridViewCell(categoryName: "Crew", movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList)
                        .background(.white)
                    MovieDetailsReviewCell(categoryName: "Reviews", movieReview: viewModel.arrReviewMovieList.first ?? nil)
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
            .navigationBarTitle("Movie Detail", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movieId: 0)
    }
}
