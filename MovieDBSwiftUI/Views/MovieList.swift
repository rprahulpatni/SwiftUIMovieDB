//
//  MovieList.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var viewModel : MovieListViewModel = MovieListViewModel()
    @State private var gridVLayout : [GridItem] = [GridItem()]
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridVLayout) {
                    ForEach(viewModel.arrMovieList, id: \.id) { movies in
                        NavigationLink(destination: {
                            MovieDetails(movieId: movies.id,isFromSearch: false, movieSearchData: nil)
                        }, label: {
                            MovieListCell(moviesData: movies)
                        })
                    }
                }
                .padding(.all, 10)
            }
            .onAppear(perform: {
                viewModel.getMovieList(true)
            })
            .navigationBarTitle("Movie's List",displayMode: .inline)
            .toolbar {
                NavigationLink(destination: SearchMovie()) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
