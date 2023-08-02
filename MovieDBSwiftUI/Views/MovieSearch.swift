//
//  MovieSearch.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieSearch: View {
    // MARK: - Properties
    /// ObservedObject: A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.
    /// The ViewModel responsible for data flow in this view.
//    @ObservedObject var viewModel: MovieSearchViewModel = MovieSearchViewModel()
    @StateObject private var viewModel: MovieSearchViewModel
    init(viewModel: MovieSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    /// @State is a property wrapper used to declare a mutable state variable within a SwiftUI View.
    /// GridItem for LazyVGrid
    @State private var gridVLayout : [GridItem] = [GridItem()]

    var body: some View {
        NavigationStack{
            VStack {
                //For displaying data from API call
                if viewModel.arrMovieList.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridVLayout) {
                            ForEach(viewModel.arrMovieList, id: \.id) { item in
                                NavigationLink{
                                    //Navigate to MovieDetails with specified MovieId
                                    let dataProvider = MovieDetailsDataProvider()
                                    let viewModel = MovieDetailsViewModel(dataProvider: dataProvider, movieId: item.id ?? 0)
                                    MovieDetails(viewModel: viewModel)
                                    //On disappear of MovieDetails view save movie data to coreData
                                        .onDisappear{
                                            self.saveSearch(item: item)
                                        }
                                } label: {
                                    //For displaying Movie details using @ViewBuilder
                                    SearchUI(item: item)
                                }
                            }
                        }
                        .padding(.all, 10)
                    }
                } else {
                    //For displaying Recently Searched movies from coredata
                    if viewModel.recentSearches.count > 0 {
                        Text(StringConstants.sectionHeaderRecentlySearched)
                            .hAlign(.leading)
                            .padding(.leading, 15)
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridVLayout) {
                                ForEach(viewModel.recentSearches, id: \.id) { item in
                                    let movie = MovieSearchData(id: Int(item.id), posterPath: item.posterPath, title: item.title)
                                    NavigationLink{
                                        //Navigate to MovieDetails with specified MovieId
                                        let dataProvider = MovieDetailsDataProvider()
                                        let viewModel = MovieDetailsViewModel(dataProvider: dataProvider, movieId: Int(item.id))
                                        MovieDetails(viewModel: viewModel)
                                    } label: {
                                        //For displaying Movie details using @ViewBuilder
                                        SearchUI(item: movie)
                                    }
                                }
                            }
                            .padding(.all, 10)
                        }
                    } else {
                        //For displaying no record found when no movie is stored in coredata
                        VStack(alignment: .center, spacing: 10){
                            Image(systemName: StringConstants.placeholderImageSearch)
                                .resizable()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                            Text(StringConstants.noRecordFound)
                                .foregroundColor(.gray.opacity(0.3))
                                .font(.headline)
                        }
                        .padding(15)
                        .hAlign(.center)
                        .vAlign(.center)
                    }
                }
            }//Setting Navigation bar details
            .navigationBarTitle(StringConstants.navHeaderMovieSearch,displayMode: .inline)
            //Hiding native navigation back button
            .navigationBarBackButtonHidden()
            //Showing custom back button
            .navigationBarItems(leading: CustomBackButton())
            //For displaying Search Bar with NavigationBar
            .searchable(text: $viewModel.searchText)
            //OnSubmit of Search button from keyboard
            .onSubmit(of: .search, {
                //Fetching data on click of search button
                self.viewModel.getMovieList(true, searchText: viewModel.searchText)
            })//Fetching data on change of Search text
            .onChange(of: viewModel.searchText, perform: { newValue in
                if newValue.isEmpty {
                    self.viewModel.arrMovieList = []
                } else {
                    self.viewModel.arrMovieList = []
                    self.viewModel.getMovieList(true, searchText: viewModel.searchText)
                }
            })
            .onAppear{
                self.viewModel.getSearchedMovieFromCoreData()
            }
        }
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying search details like poster image and title
    @ViewBuilder
    func SearchUI(item: MovieSearchData) -> some View {
        HStack(alignment: .center) {
            HStack(spacing: 10){
                //For displaying Movie Image
                //Using SDWebImageView for displaying image with cache, placeholder
                let imgUrl = URL(string: imagePath +  "\(item.posterPath ?? "")")
                CustomSDWebImageView(imgURL: imgUrl, imgWidth: 40, imgHeight: 40, placeholderImage: StringConstants.placeholderImageFilm, isCircle: false)
                
                //For displaying Movie Title
                Text(item.title ?? "")
                    .foregroundColor(.black)
                    .font(.headline)
                    .lineLimit(1)
            }.padding(.all, 15)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    //Function to save search text as a new SearchItem entity in Core Data
    private func saveSearch(item: MovieSearchData) {
        withAnimation {
            self.viewModel.saveSearchedMovieToCoreData(item: item)
        }
    }
}
