//
//  MovieReviewDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 23/07/23.
//

import SwiftUI

struct MovieReviewDetails: View {
    @ObservedObject private var viewModel : MovieDetailsViewModel = MovieDetailsViewModel()
    var movieId: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List(viewModel.arrReviewMovieList, id: \.id) { item in
                MovieReviewCell(movieReview: item)
            }
            .listStyle(.plain)
            .onAppear{
                viewModel.getMovieReviewDetails(movieId)
            }
        }
        .navigationBarTitle("Reviews", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct MovieReviewDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieReviewDetails()
    }
}
