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
            ViewForSimilarMovies()
        } else {
            ViewForCastNCrew()
        }
    }
    
    @ViewBuilder
    func ViewForSimilarMovies() -> some View {
        VStack(alignment: .center,spacing: 20) {
            ZStack(alignment: .bottom) {
                let imgUrl = URL(string: imagePath +  "\(movieSimilar?.posterPath ?? "")")
                WebImage(url: imgUrl).placeholder{
                    Image(systemName: "film")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 120, height: 140)
                        .background(.gray.opacity(0.6))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 140)
                .clipped()
                
                Rectangle()
                    .foregroundColor(Color.black)
                    .opacity(0.5)
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
    
    @ViewBuilder
    func ViewForCastNCrew() -> some View {
        VStack(alignment: .center,spacing: 10) {
            let imgUrl = URL(string: imagePath +  "\(movieCastNCrew?.profilePath ?? "")")
            WebImage(url: imgUrl).placeholder{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .background(.gray.opacity(0.5))
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
            .cornerRadius(40)
            .clipShape(Circle())
            Text(movieCastNCrew?.name ?? "")
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
                .frame(height: 35)
        }.frame(width: 100, height: 140)
    }
}
