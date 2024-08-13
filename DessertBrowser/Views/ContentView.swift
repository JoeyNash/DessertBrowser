//
//  ContentView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/12/24.
//

import SwiftUI

struct ContentView: View {
  
  var service: MealService = MealServiceAPI()

  @State var meals: [MealBase] = []

  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), alignment: .bottom)], spacing: 12) {
        ForEach(meals.sorted(by: { $0.name < $1.name }), id: \.self) { meal in
          DessertThumbnailView(meal: meal)
        }
      }
    }
    .task {
      do {
        meals = try await service.getDessertList()
      } catch let error {
        debugPrint(error)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
