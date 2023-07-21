//
//  MovieDetailsSectionWithGridViewCell.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsSectionWithGridViewCell: View {
    var categoryName: String = ""
    var movieSimilar: [MovieSimilarData]
    var movieCastNCrew: [MovieCastNCrewData]
    @State private var gridHLayout : [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.all, 15)
                .padding(.bottom, -10)
            Divider()
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: gridHLayout, alignment: .center, spacing: 10) {
                    if categoryName == "Similar Results" {
                        ForEach(movieSimilar, id: \.id) { item in
                            MovieDetailsGridViewCell(movieSimilar: item, movieCastNCrew: nil, categoryName: self.categoryName)
                        }
                    } else {
                        ForEach(movieCastNCrew, id: \.id) { item in
                            MovieDetailsGridViewCell(movieSimilar: nil, movieCastNCrew: item, categoryName: self.categoryName)
                        }
                    }
                }
            }.padding(.all, 10)
        }
        .background(.clear)
    }
}

