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
    
    //Created ViewBuilder for Image View
    @ViewBuilder
    func MovieImageView() -> some View {
        let imgUrl = URL(string: "\(imagePath)" + "\(moviesData.posterPath ?? "")")
        WebImage(url: imgUrl).placeholder{
            Image(systemName: "film")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 80, height: 80)
                .background(.gray.opacity(0.6))
        }
        .resizable()
        .indicator(.activity)
        .transition(.fade)
//        .aspectRatio(contentMode: .fill)
        .frame(width: 80, height: 80)
        .scaledToFit()
        .clipped()
        .background(.gray.opacity(0.6))
    }
    
    //Created ViewBuilder for Other Details View
    @ViewBuilder
    func MovieDetailsView() -> some View {
        VStack(alignment: .leading, spacing: 05){
            Text("\(moviesData.title ?? "")").fontWeight(.semibold).lineLimit(1)
                .foregroundColor(.black)
            HStack {
                Image(systemName: "calendar")
                let releaseDate = DateFormatter.convertDateString(moviesData.releaseDate ?? "")
                Text(releaseDate)
            }
            .font(.caption)
            .foregroundColor(.gray)
            HStack {
                Image(systemName: "hand.thumbsup")
                Text("\(moviesData.voteCount ?? 0)" + " | Rate: " + String(format: "%0.1f", (moviesData.voteAverage ?? 0.0)) + "/10")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}

