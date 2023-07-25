//
//  MovieReviewCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 23/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieReviewCell: View {
    var movieReview: MovieReviewsData?
    //State variable to show review content in full and limited manner using bool value
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            //For displaying review author details
            ReviewAuthorsDetails()
            //For displaying review content
            Text(movieReview?.content ?? "")
                .font(.caption)
                .foregroundColor(.black)
                .lineLimit(isExpanded == true ? 1000 : 5)
            //Button for showing review content in full and limited
            Button(action: {
                //Handlling isExpanded toggle condition
                isExpanded.toggle()
            }, label: {
                //Button title as per expanded toggle condition
                Text(isExpanded == true ? "View Less" : "View More")
                    .font(.caption2)
                    .foregroundColor(.blue)
                    .hAlign(.trailing)
                    .padding(.leading)
            })
            .frame(height: 20)
        }
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying author details
    @ViewBuilder
    func ReviewAuthorsDetails()-> some View {
        HStack{
            //For displaying Movie Image
            //Using SDWebImageView for displaying image with cache, placeholder
            let imgUrl = URL(string: imagePath +  "\(movieReview?.authorDetails?.avatarPath ?? "")")
            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 40, imgHeight: 40, placeholderImage: "person.circle.fill", isCircle: true)
            
            //For displaying Movie review author name
            Text(movieReview?.authorDetails?.username?.capitalized ?? "NA")
                .font(.caption)
        }
        .foregroundColor(.black)
    }
}

