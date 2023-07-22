//
//  SearchMovie.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct SearchMovie: View {
    @ObservedObject var viewModel: SearchMovieViewModel = SearchMovieViewModel()
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
    @State private var gridVLayout : [GridItem] = [GridItem()]

    var body: some View {
        NavigationStack{
            VStack {
                if viewModel.arrMovieList.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridVLayout) {
                            ForEach(viewModel.arrMovieList, id: \.id) { item in
                                NavigationLink{
                                    MovieDetails(movieId: item.id ?? 0, isFromSearch: true, movieSearchData: item)
                                } label: {
                                    SearchUI(item: item)
                                }
                            }
                        }
                        .padding(.all, 10)
                    }
                } else {
                    Text("Recently Searched")
                        .hAlign(.leading)
                        .padding(.leading, 15)
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridVLayout) {
                            ForEach(recentSearches, id: \.id) { item in
                                let movie = MovieSearchData(id: Int(item.id), posterPath: item.posterPath, title: item.title)
                                NavigationLink{
                                    MovieDetails(movieId: Int(item.id), isFromSearch: false, movieSearchData: nil)
                                } label: {
                                    SearchUI(item: movie)
                                }
                            }
                        }
                        .padding(.all, 10)
                    }
                }
            }
            .navigationBarTitle("Search",displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
            .searchable(text: $viewModel.searchText)
            .onSubmit(of: .search, {
                viewModel.getMovieList(true, searchText: viewModel.searchText)
            })
            .onChange(of: viewModel.searchText, perform: { newValue in
                if newValue.isEmpty {
                    self.viewModel.arrMovieList = []
                }
            })
        }
    }
    
    @ViewBuilder
    func SearchUI(item: MovieSearchData) -> some View {
        HStack(alignment: .center) {
            HStack(spacing: 10){
                let imgUrl = URL(string: imagePath +  "\(item.posterPath ?? "")")
                WebImage(url: imgUrl).placeholder{
                    Image(systemName: "film")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .background(.gray.opacity(0.5))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .background(.gray.opacity(0.5))
                .clipped()
                
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
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie()
    }
}
