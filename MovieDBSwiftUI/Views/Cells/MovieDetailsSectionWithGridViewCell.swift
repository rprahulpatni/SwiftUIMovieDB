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
    var onTab:(Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            //For displaying Category Name
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.all, 15)
                .padding(.bottom, -10)
            Divider()
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: gridHLayout, alignment: .center, spacing: 10) {
                    //For displaying Similar Results data
                    if categoryName == StringConstants.sectionHeaderSimilarResults {
                        if movieSimilar.count > 0 {
                            ForEach(movieSimilar, id: \.id) { item in
                                //Reusable view for displaying Similar results with category name
                                MovieDetailsGridViewCell(movieSimilar: item, movieCastNCrew: nil, categoryName: self.categoryName)
                                    .onTapGesture {
                                        self.onTab(item.id ?? 0)
                                    }
                            }
                        } else {
                            Text(StringConstants.noRecordFound)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .padding(.bottom, 10)
                        }
                    } else {
                        //For displaying Cast n Crew data
                        if movieCastNCrew.count > 0 {
                            ForEach(movieCastNCrew, id: \.id) { item in
                                //Reusable view for displaying Cast n Crew with category name
                                MovieDetailsGridViewCell(movieSimilar: nil, movieCastNCrew: item, categoryName: self.categoryName)
                            }
                        } else {
                            Text(StringConstants.noRecordFound)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .padding(.bottom, 10)
                        }
                    }
                }
            }.padding(.all, 10)
        }
        .background(.clear)
    }
}

