//
//  MovieList.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

// MARK: - MovieList View
struct MovieList: View {
    // MARK: - Properties
    /// ObservedObject: A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.
    /// The ViewModel responsible for data flow in this view.
    //    @ObservedObject var viewModel : MovieListViewModel = MovieListViewModel()
    @StateObject private var viewModel: MovieListViewModel
    init(viewModel: MovieListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    /// @State is a property wrapper used to declare a mutable state variable within a SwiftUI View.
    /// GridItem for LazyVGrid
    @State private var gridVLayout : [GridItem] = [GridItem()]
    
    var body: some View {
        //Navigation Stack for creating navigation flow
        NavigationStack{
            //Scrollview for LazyVGrid view scolling
            ScrollView(.vertical, showsIndicators: false) {
                //LazyVGrid for vertical grid view with grid layout
                LazyVGrid(columns: gridVLayout) {
                    //ForEach for binding data to LazyVGrid view
                    ForEach(viewModel.arrMovieList, id: \.id) { movies in
                        NavigationLink{
                            //NavigationLink for navigating to movie details page with movieID
                            let dataProvider = MovieDetailsDataProvider()
                            let viewModel = MovieDetailsViewModel(dataProvider: dataProvider, movieId: movies.id ?? 0)
                            MovieDetails(viewModel: viewModel)
                        } label: {
                            //For displaying data in LazyVGrid
                            MovieListCell(moviesData: movies)
                        }
                        //Code for Pagination when list view scrolles to last of list
                        if movies.id == viewModel.arrMovieList.last?.id {
                            //Checking page count is less than or equal to total pages
                            if viewModel.pageCount <= viewModel.totalPages {
                                //Showing loader
                                ProgressView(label: {
                                    Text(StringConstants.loading)
                                }).progressViewStyle(.circular)
                                    .tint(.gray)
                                    .onAppear(perform: {
                                        // Fetch data when the view appears.
                                        viewModel.getMovieList(false)
                                    })
                            }
                        }
                    }
                }
                .padding(.all, 10)
            }
            .refreshable{
                // Pull to refresh
                viewModel.getResetPageNTotalCount()
                viewModel.getMovieList(true)
            }
            .onAppear(perform: {
                // Fetch data when the view appears.
                viewModel.getMovieList(true)
            })//Setting Navigation bar details
            .navigationBarTitle(StringConstants.navHeaderMovieList,displayMode: .inline)
            //Open if you want to change Navigation header color
            //.navigationBarColor(backgroundColor: .purple, tintColor: .white)
            .toolbar {
                //Navigate to SearchView on click of Search NavigationLink
                NavigationLink{
                    let dataProvider = MovieSearchDataProvider()
                    let viewModel = MovieSearchViewModel(dataProvider: dataProvider)
                    MovieSearch(viewModel: viewModel)
                } label: {
                    //For displaying search icon
                    Image(systemName: StringConstants.placeholderImageSearch)
                }
            }
        }
        .overlay{
            //Overlay with custom loading indicator
            //showProgress is based on ViewModel api response
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

