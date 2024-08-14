//
//  DessertDetailView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/13/24.
//

import SwiftUI

class DessertDetailViewModel: ObservableObject {
  let id: String
  @Published var mealDetails: MealDetails = MealDetails(id: "", name: "", thumbnailURL: "", instructions: "")
  @Published var isShowingError = false
  @Published var error: Error? = nil
  @Published var isLoading = true

  init(id: String) {
    self.id = id
  }
}

struct DessertDetailView: View {
  @EnvironmentObject var service: MealServiceAPI
  @ObservedObject var viewModel: DessertDetailViewModel

  func getDetails() {
    Task { @MainActor in
      do {
        viewModel.mealDetails = try await service.getDessertDetails(for: viewModel.id)
        viewModel.isLoading = false
      } catch let error {
        viewModel.error = error
        viewModel.isShowingError = true
        viewModel.isLoading = false
      }
    }
  }
  var body: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 12) {
        AsyncImage(url: URL(string: viewModel.mealDetails.thumbnailURL)) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          ProgressView()
            .progressViewStyle(.circular)
        }
        .frame(width: 200, height: 200)
        Text("Ingredients:")
          .fontWeight(.bold)
          .padding()
        LazyVStack {
          ForEach(viewModel.mealDetails.ingredientMeasuresStrings, id: \.self) { ingredient in
            Text(ingredient)
          }
        }
        Text("Instructions:")
          .fontWeight(.bold)
          .padding()
        Text(viewModel.mealDetails.instructions)
          .padding()
      }
      .modifier(LoadingViewOverlay(isShowing: viewModel.isLoading))
      .alert(viewModel.error.debugDescription, isPresented: $viewModel.isShowingError) {
        Button("Retry", role: .cancel) {
          viewModel.isShowingError = false
          viewModel.error = nil
          getDetails()
        }
      }
    }
    .task {
      getDetails()
    }
  }
}

struct DessertDetailView_Previews: PreviewProvider {
  static var previews: some View {
    DessertDetailView(viewModel: DessertDetailViewModel(id: "52767"))
      .environmentObject(MealServiceAPI())
  }
}
