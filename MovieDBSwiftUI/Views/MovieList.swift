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
                            MovieDetails(movieId: movies.id ?? 0)
                        }, label: {
                            MovieListCell(moviesData: movies)
                        })
                        if movies.id == viewModel.arrMovieList.last?.id {
                            if viewModel.pageCount <= viewModel.totalPages {
                                ProgressView(label: {
                                    Text("Loading")
                                }).progressViewStyle(.circular)
                                    .tint(.red)
                                    .onAppear(perform: {
                                        viewModel.getMovieList(false)
                                    })
                            }
                        }
                    }
                }
                .padding(.all, 10)
            }
            .refreshable{
                viewModel.pageCount = 1
                viewModel.totalPages = 0
                viewModel.arrMovieList.removeAll()
                viewModel.getMovieList(true)
            }
            .onAppear(perform: {
                viewModel.getMovieList(true)
            })
            .navigationBarTitle("Movie's List",displayMode: .inline)
            //Open if you want to change Navigation header color
//            .navigationBarColor(backgroundColor: .purple, tintColor: .white)
            .toolbar {
                NavigationLink(destination: SearchMovie()) {
                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.white)
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
