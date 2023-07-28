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
    var movieReview: [MovieReviewsData]
    @State private var isExpanded: Bool = false
    @State private var gridVLayout : [GridItem] = [GridItem()]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.all, 15)
                .padding(.bottom, -10)
            Divider()
            if movieReview.count > 0 {
                //                MovieReviewCell(movieReview: movieReview?.first)
                //                    .padding(.leading, 15)
                //                    .padding(.trailing, 15)
                //                Divider()
                //                NavigationLink(destination: {
                //                    MovieReviewDetails(movieReview: self.movieReview ?? [])
                //                }, label: {
                //                    Text(StringConstants.btnViewAllReviews)
                //                        .font(.caption)
                //                        .frame(height: 40)
                //                        .frame(maxWidth: .infinity)
                //                        .padding(.bottom, 5)
                //                })
                
                if !isExpanded {
                    //For displaying single reviews
                    MovieReviewCell(movieReview: movieReview.first)
                } else {
                    //For displaying list of reviews
                    LazyVGrid(columns: gridVLayout) {
                        ForEach(movieReview, id: \.id) { movies in
                            MovieReviewCell(movieReview: movies)
                        }
                    }
                }
                //Button for showing review content in full and limited
                Button(action: {
                    //Handlling isExpanded toggle condition
                    withAnimation(.easeInOut(duration: 1)) {
                        isExpanded.toggle()
                    }
                }, label: {
                    //Button title as per expanded toggle condition
                    Text(isExpanded == true ? StringConstants.btnViewLessReviews : StringConstants.btnViewAllReviews)
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .hAlign(.center)
                        .frame(height: 40)
                        .padding(.leading)
                        .padding(.bottom, 10)
                })
            } else {
                Text(StringConstants.noRecordFound)
                    .hAlign(.leading)
                    .frame(height: 50)
                    .padding(.leading, 15)
                    .padding(.bottom, 10)
            }
        }
        .background(.clear)
    }
}

