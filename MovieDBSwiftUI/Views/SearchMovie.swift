//
//  SearchMovie.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

struct SearchMovie: View {
    @ObservedObject var viewModel: SearchMovieViewModel = SearchMovieViewModel()

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.navigationBarTitle("Search",displayMode: .inline)
            .searchable(text: $viewModel.searchText)
    }
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie()
    }
}
