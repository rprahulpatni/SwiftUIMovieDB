//
//  SearchMovie.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchMovie: View {
    @ObservedObject var viewModel: SearchMovieViewModel = SearchMovieViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                List(viewModel.arrMovieList, id: \.id){ item in
                    NavigationLink(destination: {
                        MovieDetails(movieId: item.id ?? 0)
                    }, label: {
                        SearchUI(item: item)
                    })
                }.listStyle(.plain)
            }.navigationBarTitle("Search",displayMode: .inline)
                .searchable(text: $viewModel.searchText)
                .onSubmit(of: .search, {
                    viewModel.getMovieList(false, searchText: viewModel.searchText)
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
        HStack{
            let imgUrl = URL(string: imagePath +  "\(item.posterPath ?? "")")
            WebImage(url: imgUrl).placeholder{
                Image(systemName: "film")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .background(.gray.opacity(0.5))
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30, height: 30)
            
            Text(item.title ?? "")
                .font(.caption)
                .lineLimit(1)
        }
    }
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie()
    }
}
