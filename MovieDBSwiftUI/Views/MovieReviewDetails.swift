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
        //Converting movieReview arry to set of unique array
        let movieReviewSet = Array(Set(movieReview))
        self.movieReview = movieReviewSet
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //For displaying list of reviews
            List(self.movieReview, id: \.id) { item in
                //Resulable custom view for displaying review data
                MovieReviewCell(movieReview: item)
                    .listRowBackground(Color.white)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }//Setting Navigation bar details
        .navigationBarTitle(StringConstants.navHeaderMovieReview, displayMode: .inline)
        //Hiding native navigation back button
        .navigationBarBackButtonHidden()
        //Showing custom back button
        .navigationBarItems(leading: CustomBackButton())
    }
}
