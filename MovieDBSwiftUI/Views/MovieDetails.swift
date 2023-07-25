//
//  MovieDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import CoreData

struct MovieDetails: View {
    // MARK: - Properties
    /// ObservedObject: A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.
    /// The ViewModel responsible for data flow in this view.
    @ObservedObject var viewModel : MovieDetailsViewModel = MovieDetailsViewModel()
    /// @State is a property wrapper used to declare a mutable state variable within a SwiftUI View.
    /// movieId for getting specifed movie details
    @State var movieId: Int = 0

    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            //Scrollview for view scolling
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    //Reusable view for displaying Movie Details
                    MovieDetailsViewCell(movieDetails: viewModel.dictMovieDetails)
                    //Reusable view for displaying Movie Cast member list with section header
                    MovieDetailsSectionWithGridViewCell(categoryName: StringConstants.sectionHeaderCast, movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCastList, onTab: { item in
                    })
                        .background(.white)
                    //Reusable view for displaying Movie Crew member list with section header
                    MovieDetailsSectionWithGridViewCell(categoryName: StringConstants.sectionHeaderCrew, movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList, onTab: { item in
                    })
                        .background(.white)
                    //Reusable view for displaying Movie Review with section header
                    MovieDetailsReviewCell(categoryName: StringConstants.sectionHeaderReviews, movieId: self.movieId, movieReview: viewModel.arrReviewMovieList)
                        .background(.white)
                    //Reusable view for displaying Movie Similar list with section header
                    MovieDetailsSectionWithGridViewCell(categoryName: StringConstants.sectionHeaderSimilarResults, movieSimilar: viewModel.arrSimilarMovieList, movieCastNCrew: viewModel.arrMovieCrewList, onTab: { item in
                        //Updating movieId for fetching details assosiacted with specified movieID
                        self.movieId = item
                        //Removing all values from array for updating new value
                        self.viewModel.arrMovieCastList.removeAll()
                        self.viewModel.arrMovieCrewList.removeAll()
                        self.viewModel.arrSimilarMovieList.removeAll()
                        self.viewModel.arrReviewMovieList.removeAll()
                        //Fetching new movie details with updated movieId
                        self.callAPI()
                    })
                        .background(.white)
                }
            }
            .onAppear{
                //Fetching movie details on view appears
                self.callAPI()
            }
            .overlay{
                //Overlay with custom loading indicator
                //showProgress is based on ViewModel api response
                LoadingView(showProgress: $viewModel.isLoading)
            }//Setting Navigation bar details
            .navigationBarTitle(StringConstants.navHeaderMovieDetail,displayMode: .inline)
            //Hiding native navigation back button
            .navigationBarBackButtonHidden()
            //Showing custom back button
            .navigationBarItems(leading: CustomBackButton())
        }
    }
    
    //Private method for fetching movie details from viewModel
    private func callAPI() {
        //For fetching Movie Details
        viewModel.getMovieDetails(movieId)
        //For fetching movie cast n crew
        viewModel.getMovieCastNCrew(movieId)
        //For fetching movie similar movie list
        viewModel.getMovieSimilarDetails(movieId)
        //For fetching movie reviews
        viewModel.getMovieReviewDetails(movieId)
    }
}

