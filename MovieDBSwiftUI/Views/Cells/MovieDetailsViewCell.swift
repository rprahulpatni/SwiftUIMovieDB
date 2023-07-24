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
            let imgBackdropUrl = URL(string: imagePath +  "\(movieDetails.backdropPath ?? "")")
            WebImage(url: imgBackdropUrl).placeholder{
                Image(systemName: "film")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.5))
            }
                .resizable()
                .frame(height: 220)
                .frame(maxWidth: .infinity)
            MovieDetailsTitle()
            MovieDetailsDesc()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
    
    @ViewBuilder
    func MovieDetailsTitle()-> some View {
        HStack(alignment: .top,spacing: 10){
            let imgUrl = URL(string: imagePath +  "\(movieDetails.posterPath ?? "")")
            WebImage(url: imgUrl)
                .resizable()
                .frame(width: 100,height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.white, lineWidth: 2)
                }
                .shadow(radius: 5)
            
            HStack(spacing: 10) {
                Text(movieDetails.title ?? "")
                    .font(.headline)
                Spacer()
                Text(String(format: "%0.1f", movieDetails.voteAverage ?? 0) + "/10")
                    .font(.footnote)
            }
            .offset(y: 40)
            .padding(.top, 40)
        }
        .padding(.trailing, 15)
        .padding(.leading, 15)
        .offset(y: -80)
        .padding(.bottom, -80)
    }
    
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

//struct MovieDetailsViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsViewCell()
//    }
//}
