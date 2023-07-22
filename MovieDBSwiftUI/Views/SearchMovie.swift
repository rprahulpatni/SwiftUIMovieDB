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
    //    @Environment(\.managedObjectContext) private var viewContext
    //    @FetchRequest(
    //        entity: SearchedMovieData.entity(),
    //        sortDescriptors: [NSSortDescriptor(keyPath: \SearchedMovieData.timestamp, ascending: false)]
    //    ) private var allRecentSearches: FetchedResults<SearchedMovieData>
    //    private var recentSearches: [SearchedMovieData] {
    //            Array(allRecentSearches.prefix(5))
    //        }
    
    var body: some View {
        NavigationStack{
            VStack {
                List(viewModel.arrMovieList, id: \.id){ item in
                    NavigationLink{
                        MovieDetails(movieId: item.id ?? 0)
                            .onAppear{
                                //                                saveSearch(item: item)
                            }
                    } label: {
                        SearchUI(item: item)
                    }
                }.listStyle(.plain)
            }
            .navigationBarTitle("Search",displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
            .searchable(text: $viewModel.searchText)
            .onSubmit(of: .search, {
                viewModel.getMovieList(false, searchText: viewModel.searchText)
            })
            .onChange(of: viewModel.searchText, perform: { newValue in
                if newValue.isEmpty {
                    self.viewModel.arrMovieList = []
                }
            })
            .onAppear{
                //                    print(recentSearches)
            }
        }
    }
    
    @ViewBuilder
    func SearchUI(item: MovieSearchData) -> some View {
        HStack{
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
                .font(.headline)
                .lineLimit(1)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
    
    // Function to save search text as a new SearchItem entity in Core Data
    //    private func saveSearch(item: MovieSearchData) {
    //        withAnimation {
    //            let newSearch = SearchedMovieData(context: viewContext)
    //            newSearch.timestamp = Date()
    //            newSearch.id = Int64(item.id ?? 0)
    //            newSearch.title = item.title
    //            newSearch.posterPath = item.posterPath
    //
    //            // Optional: If you want to limit the number of recent searches to 5, remove the oldest one
    //            if recentSearches.count >= 5 {
    //                viewContext.delete(recentSearches.last!)
    //            }
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Handle the error
    //                print("Error saving search: \(error)")
    //            }
    //        }
    //    }
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie()
    }
}
