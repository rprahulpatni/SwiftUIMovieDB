//
//  MovieSearch.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct MovieSearch: View {
    @ObservedObject var viewModel: MovieSearchViewModel = MovieSearchViewModel()
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
                                    MovieDetails(movieId: item.id ?? 0)
                                        .onDisappear{
                                            self.saveSearch(item: item)
                                        }
                                } label: {
                                    SearchUI(item: item)
                                }
                            }
                        }
                        .padding(.all, 10)
                    }
                } else {
                    if recentSearches.count > 0 {
                        Text("Recently Searched")
                            .hAlign(.leading)
                            .padding(.leading, 15)
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridVLayout) {
                                ForEach(recentSearches, id: \.id) { item in
                                    let movie = MovieSearchData(id: Int(item.id), posterPath: item.posterPath, title: item.title)
                                    NavigationLink{
                                        MovieDetails(movieId: Int(item.id))
                                            .onDisappear{
                                                self.saveSearch(item: movie)
                                            }
                                    } label: {
                                        SearchUI(item: movie)
                                    }
                                }
                            }
                            .padding(.all, 10)
                        }
                    } else {
                        VStack(alignment: .center, spacing: 10){
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                            Text("No Result Found!!")
                                .foregroundColor(.gray.opacity(0.3))
                                .font(.headline)
                        }
                        .padding(15)
                        .hAlign(.center)
                        .vAlign(.center)
                    }
                }
            }
            .navigationBarTitle("Search",displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
            .searchable(text: $viewModel.searchText)
            .onSubmit(of: .search, {
                self.viewModel.getMovieList(true, searchText: viewModel.searchText)
            })
            .onChange(of: viewModel.searchText, perform: { newValue in
                if newValue.isEmpty {
                    self.viewModel.arrMovieList = []
                } else {
                    self.viewModel.arrMovieList = []
                    self.viewModel.getMovieList(true, searchText: viewModel.searchText)
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
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(.gray.opacity(0.5))
                }
                .resizable()
                .indicator(.activity)
                .transition(.fade)
                .frame(width: 40, height: 40)
                .scaledToFit()
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

struct MovieSearch_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearch()
    }
}
