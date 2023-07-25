//
//  MovieDetailsReviewCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 22/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsReviewCell: View {
    var categoryName: String = ""
    var movieId: Int = 0
    var movieReview: [MovieReviewsData]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.all, 15)
                .padding(.bottom, -10)
            Divider()
            if movieReview!.count > 0 {
                MovieReviewCell(movieReview: movieReview?.first)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                Divider()
                NavigationLink(destination: {
                    MovieReviewDetails(movieReview: self.movieReview ?? [])
                }, label: {
                    Text("View All Reviews")
                        .font(.caption)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                })
            } else {
                Text("No Record Found!!")
                    .hAlign(.leading)
                    .frame(height: 50)
                    .padding(.leading, 15)
                    .padding(.bottom, 10)
            }
        }
        .background(.clear)
    }
}

