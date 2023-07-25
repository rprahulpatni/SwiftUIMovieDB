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
    // MARK: - Properties
    /// ObservedObject: A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.
    /// The ViewModel responsible for data flow in this view.
    @ObservedObject var viewModel: MovieSearchViewModel = MovieSearchViewModel()
    ///@Environment is a property wrapper in SwiftUI that allows you to access values from the environment of the current view hierarchy.
    ///managedObjectContext for viewContext
    @Environment(\.managedObjectContext) private var viewContext
    //Fetching data from coredata using sorting
    @FetchRequest(
        entity: SearchedMovie.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchedMovie.timestamp, ascending: false)],
        animation: .easeInOut(duration: 0.3)
    )
    //Storing FetchedResults from coredate in array
    private var allRecentSearches: FetchedResults<SearchedMovie>
    ///The prefix(_:) method allows us to take the first 5 elements of the fetched results array.
    private var recentSearches: [SearchedMovie] {
        Array(allRecentSearches.prefix(5))
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
                                    MovieDetails(movieId: item.id ?? 0)
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
                    if recentSearches.count > 0 {
                        Text("Recently Searched")
                            .hAlign(.leading)
                            .padding(.leading, 15)
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridVLayout) {
                                ForEach(recentSearches, id: \.id) { item in
                                    let movie = MovieSearchData(id: Int(item.id), posterPath: item.posterPath, title: item.title)
                                    NavigationLink{
                                        //Navigate to MovieDetails with specified MovieId
                                        MovieDetails(movieId: Int(item.id))
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
            }//Setting Navigation bar details
            .navigationBarTitle("Search",displayMode: .inline)
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
        }
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    @ViewBuilder
    func SearchUI(item: MovieSearchData) -> some View {
        HStack(alignment: .center) {
            HStack(spacing: 10){
                //For displaying Movie Image
                //Using SDWebImageView for displaying image with cache, placeholder
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
            do {
                //Updating new searched movie details to viewContext
                let newSearch = SearchedMovie(context: viewContext)
                newSearch.timestamp = Date()
                newSearch.id = Int64(item.id ?? 0)
                newSearch.title = item.title
                newSearch.posterPath = item.posterPath
                
                // Optional: If you want to limit the number of recent searches to 5, remove the oldest one
                if recentSearches.count >= 5 {
                    viewContext.delete(recentSearches.last!)
                }
                //Saving viewContext data to coredata
                try viewContext.save()
            } catch {
                // Handle the error
                print("Error saving search: \(error)")
            }
        }
    }
}
