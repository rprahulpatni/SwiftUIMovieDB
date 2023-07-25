//
//  MovieListCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieListCell: View {
    var moviesData: MovieListData
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: 10){
                //Using View Builder for shorter code
                MovieImageView()
                MovieDetailsView()
            }.padding(.all, 15)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying imageview
    @ViewBuilder
    func MovieImageView() -> some View {
        //For displaying Movie Image
        //Using SDWebImageView for displaying image with cache, placeholder
        let imgUrl = URL(string: "\(imagePath)" + "\(moviesData.posterPath ?? "")")
        CustomSDWebImageView(imgURL: imgUrl, imgWidth: 80, imgHeight: 80, placeholderImage: StringConstants.placeholderImageFilm, isCircle: false)
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying other details
    @ViewBuilder
    func MovieDetailsView() -> some View {
        VStack(alignment: .leading, spacing: 05){
            //For displaying Movie Title
            Text("\(moviesData.title ?? "")").fontWeight(.semibold).lineLimit(1)
                .foregroundColor(.black)
            
            //For displaying Movie release date with calendar image
            HStack {
                Image(systemName: StringConstants.placeholderImageCalender)
                let releaseDate = DateFormatter.convertDateString(moviesData.releaseDate ?? "")
                Text(releaseDate)
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            //For displaying Movie votes with total rating with thumbsup image
            HStack {
                Image(systemName: StringConstants.placeholderImageThumbsUp)
                Text("\(moviesData.voteCount ?? 0)" + StringConstants.rate + String(format: "%0.1f", (moviesData.voteAverage ?? 0.0)) + "/10")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}

