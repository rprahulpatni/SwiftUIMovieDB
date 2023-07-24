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
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ReviewAuthorsDetails()
            Text(movieReview?.content ?? "")
                .font(.caption)
                .lineLimit(isExpanded == true ? 1000 : 5)
            Button(action: {
                isExpanded.toggle()
            }, label: {
                Text(isExpanded == true ? "View Less" : "View More")
                    .font(.caption2)
                    .foregroundColor(.blue)
                    .hAlign(.trailing)
                    .padding(.leading)
            })
            .frame(height: 20)
        }
    }
    
    @ViewBuilder
    func ReviewAuthorsDetails()-> some View {
        HStack{
            let imgUrl = URL(string: imagePath +  "\(movieReview?.authorDetails?.avatarPath ?? "")")
            WebImage(url: imgUrl).placeholder{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .background(.gray.opacity(0.5))
            }
            .resizable()
            .indicator(.activity)
            .transition(.fade)
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .cornerRadius(20)
            .clipShape(Circle())
            
            Text(movieReview?.authorDetails?.username?.capitalized ?? "NA")
                .font(.caption)
        }
    }
}

struct MovieReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieReviewCell()
    }
}
