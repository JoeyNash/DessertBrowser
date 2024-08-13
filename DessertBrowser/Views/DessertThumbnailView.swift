//
//  DessertThumbnailView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/13/24.
//

import SwiftUI

struct DessertThumbnailView: View {
  
  let meal: MealBase

  var body: some View {
    VStack {
      Text(meal.name)
        .frame(alignment: .center)
        .font(.system(size: 12))
        .multilineTextAlignment(.center)
        .padding(6)
      AsyncImage(url: URL(string: meal.thumbnailURL)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        ProgressView()
          .progressViewStyle(.circular)
      }
      .frame(width: 100, height: 100)
    }
  }
}

struct DessertThumbnailView_Previews: PreviewProvider {
  static var previews: some View {
    DessertThumbnailView(
      meal: MealBase(
        name: "Apam balik",
        thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
        id: "53049"
      )
    )
  }
}
