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
    var movieReview: MovieReviewsData?
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.all, 15)
                .padding(.bottom, -10)
            Divider()
            
            if let content = movieReview?.content, content != "" {
                ReviewAuthorsDetails()
                Text(movieReview?.content ?? "")
                    .font(.caption)
                    .lineLimit(isExpanded == true ? 1000 : 5)
                    .padding(.all, 15)
                Divider()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        isExpanded.toggle()
                    }
                }, label: {
                    Text(isExpanded == true ? "View Less Reviews" : "View All Reviews")
                        .font(.caption)
                })
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 5)
            } else {
                Text("No Record Found!!")
                    .hAlign(.leading)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
        }
        .background(.clear)
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
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .cornerRadius(20)
            .clipShape(Circle())
            
            Text(movieReview?.authorDetails?.username?.capitalized ?? "NA")
                .font(.caption)
        }
        .padding(.top, 10)
        .padding(.leading, 15)
    }
}

//struct MovieDetailsReviewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsReviewCell()
//    }
//}
