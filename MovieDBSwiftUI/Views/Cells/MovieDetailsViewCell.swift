//
//  MovieDetailsViewCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 22/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsViewCell: View {
    var movieDetails: MovieDetailsModel
    
    var body: some View {
        VStack{
            //Displaying backdrop image using viewBuilder
            MovieDetailsBackDropImage()
            //Displaying title and other details using viewBuilder
            MovieDetailsTitle()
            //Displaying description and other details using viewBuilder
            MovieDetailsDesc()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying backdrop image on header
    @ViewBuilder
    func MovieDetailsBackDropImage()-> some View {
        //For displaying Movie Image
        //Using SDWebImageView for displaying image with cache, placeholder
        let imgBackdropUrl = URL(string: imagePath +  "\(movieDetails.backdropPath ?? "")")
        CustomSDWebImageView(imgURL: imgBackdropUrl, imgWidth: 400, imgHeight: 220, placeholderImage: StringConstants.placeholderImageFilm, isCircle: false)
            .frame(maxWidth: .infinity)
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying other details like poster image, title and vote count
    @ViewBuilder
    func MovieDetailsTitle()-> some View {
        HStack(alignment: .top,spacing: 10){
            //For displaying Movie Image
            //Using SDWebImageView for displaying image with cache, placeholder
            let imgUrl = URL(string: imagePath +  "\(movieDetails.posterPath ?? "")")
            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 100, imgHeight: 160, placeholderImage: StringConstants.placeholderImageFilm, isCircle: false)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.white, lineWidth: 2)
                }
                .shadow(radius: 5)
            
            //For displaying title with vote count
            HStack(spacing: 10) {
                Text(movieDetails.title ?? "")
                    .font(.headline)
                Spacer()
                Text(String(format: "%0.1f", movieDetails.voteAverage ?? 0) + "/10")
                    .font(.footnote)
            }
            .foregroundColor(.black)
            .offset(y: 40)
            .padding(.top, 40)
        }
        .padding(.trailing, 15)
        .padding(.leading, 15)
        .offset(y: -80)
        .padding(.bottom, -80)
    }
    
    ///@ViewBuilder is a property wrapper that provides a convenient way to construct complex view hierarchies from multiple child views.
    // ViewBuilder for displaying other details like movie type, releasedate, total hours, and description
    @ViewBuilder
    func MovieDetailsDesc()-> some View {
        let genreNames = movieDetails.genres?.compactMap { genre in
            return genre.name
        }.joined(separator: ", ")
        let releaseDate = DateFormatter.convertDateString(movieDetails.releaseDate ?? "")
        let totalHours = DateFormatter.convertMinutesToHoursAndMinutes(movieDetails.runtime ?? 0)
        
        VStack(alignment: .leading, spacing: 5){
            Text("\(releaseDate) • \(totalHours)")
            Text(genreNames ?? "")
            Text(movieDetails.overview ?? "")
                .foregroundColor(.black)
        }
        .font(.caption)
        .foregroundColor(.gray)
        .padding(.all,15)
    }
}
