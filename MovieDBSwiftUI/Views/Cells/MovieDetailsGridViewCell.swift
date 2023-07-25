//
//  MovieDetailsGridViewCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsGridViewCell: View {
    var movieSimilar: MovieSimilarData?
    var movieCastNCrew: MovieCastNCrewData?
    var categoryName: String = ""
    
    var body: some View {
        if categoryName == "Similar Results" {
            //Displaying data using viewBuilder for similar results
            ViewForSimilarMovies()
        } else {
            //Displaying data using viewBuilder for cast n crew
            ViewForCastNCrew()
        }
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying similar movie details like image and title
    @ViewBuilder
    func ViewForSimilarMovies() -> some View {
        VStack(alignment: .center,spacing: 20) {
            ZStack(alignment: .bottom) {
                //For displaying Movie Image
                //Using SDWebImageView for displaying image with cache, placeholder
                let imgUrl = URL(string: imagePath +  "\(movieSimilar?.posterPath ?? "")")
                CustomSDWebImageView(imgURL: imgUrl, imgWidth: 120, imgHeight: 140, placeholderImage: "film", isCircle: false)
                
                //For creating blur view on movie image
                Rectangle()
                    .foregroundColor(Color.black)
                    .opacity(0.5)
                
                //For displaying title
                Text(movieSimilar?.title ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(height: 35)
                    .padding(.all, 10)
            }
        }.frame(width: 120, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .padding(.bottom, 20)
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying cast n crew details like image and title
    @ViewBuilder
    func ViewForCastNCrew() -> some View {
        VStack(alignment: .center,spacing: 10) {
            //For displaying Movie Image
            //Using SDWebImageView for displaying image with cache, placeholder
            let imgUrl = URL(string: imagePath +  "\(movieCastNCrew?.profilePath ?? "")")
            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 80, imgHeight: 80, placeholderImage: "person.circle.fill", isCircle: true)
                .clipShape(Circle())
            
            //For displaying name
            Text(movieCastNCrew?.name ?? "")
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
                .frame(height: 35)
        }.frame(width: 100, height: 140)
    }
}
