//
//  MovieReviewDetails.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 23/07/23.
//

import SwiftUI

struct MovieReviewDetails: View {
    var movieReview: Array<MovieReviewsData>
    init(movieReview: Array<MovieReviewsData>) {
        let movieReviewSet = Array(Set(movieReview))
        self.movieReview = movieReviewSet
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List(self.movieReview, id: \.id) { item in
                MovieReviewCell(movieReview: item)
                    .listRowBackground(Color.white)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
        .navigationBarTitle("Reviews", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: CustomBackButton())
    }
}
