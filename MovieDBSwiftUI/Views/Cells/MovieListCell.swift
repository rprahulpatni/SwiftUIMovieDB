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
                let imgUrl = URL(string: "\(imagePath + moviesData.posterPath)")
                WebImage(url: imgUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .background(.red)
                VStack(alignment: .leading, spacing: 05, content: {
                    Text("\(moviesData.title)").fontWeight(.semibold).lineLimit(1)
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "calendar")
                        let releaseDate = DateFormatter.convertDateString(moviesData.releaseDate)
                        Text(releaseDate)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("\(moviesData.voteCount)" + " | Rate: " + String(format: "%0.1f", moviesData.voteAverage) + "/10")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                })
            }.padding(.all, 15)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

//struct MovieListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListCell(moviesData: MovieListData(adult: false, backdropPath: <#T##String#>, genreIDS: <#T##[Int]#>, id: <#T##Int#>, originalLanguage: <#T##OriginalLanguage#>, originalTitle: <#T##String#>, overview: <#T##String#>, popularity: <#T##Double#>, posterPath: <#T##String#>, releaseDate: <#T##String#>, title: <#T##String#>, video: <#T##Bool#>, voteAverage: <#T##Double#>, voteCount: <#T##Int#>))
//    }
//}
