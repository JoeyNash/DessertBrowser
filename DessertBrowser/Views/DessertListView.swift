//
//  DessertListView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/12/24.
//

import SwiftUI

struct DessertListView: View {
  
  var service: MealServiceAPI = MealServiceAPI()

  @State var meals: [MealBase] = []

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), alignment: .bottom)], spacing: 12) {
          ForEach(meals.sorted(by: { $0.name < $1.name }), id: \.self) { meal in
            NavigationLink {
              DessertDetailView(id: meal.id)
                .environmentObject(service)
                .navigationTitle(meal.name)
            } label: {
              DessertThumbnailView(meal: meal)
                .shadow(color: .gray, radius: 5)
            }
          }
        }
      }
      .navigationBarTitle("Desserts", displayMode: .inline)
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
    DessertListView()
  }
}
