//
//  DessertListView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/12/24.
//

import SwiftUI

class DessertListViewModel: ObservableObject {
  @Published var meals: [MealBase] = []
  @Published var error: Error? = nil
  @Published var isShowingError = false
}

struct DessertListView: View {
  
  var service: MealServiceAPI = MealServiceAPI()
  @ObservedObject var viewModel = DessertListViewModel()

  func getMeals() {
    Task { @MainActor in
      do {
        viewModel.meals = try await service.getDessertList()
      } catch let error {
        viewModel.error = error
        viewModel.isShowingError = true
      }
    }
  }
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), alignment: .bottom)], spacing: 12) {
          ForEach(viewModel.meals.sorted(by: { $0.name < $1.name }), id: \.self) { meal in
            NavigationLink {
              DessertDetailView(viewModel: DessertDetailViewModel(id: meal.id))
                .environmentObject(service)
                .navigationTitle(meal.name)
            } label: {
              DessertThumbnailView(meal: meal)
                .shadow(color: .gray, radius: 5)
            }
          }
        }
        .alert(viewModel.error.debugDescription, isPresented: $viewModel.isShowingError) {
          Button("Retry", role: .cancel) {
            viewModel.isShowingError = false
            viewModel.error = nil
            getMeals()
          }
        }
      }
      .navigationBarTitle("Desserts", displayMode: .inline)
    }
    .task {
      getMeals()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    DessertListView()
  }
}
