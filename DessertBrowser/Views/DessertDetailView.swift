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
  static func makePreviewViewModel() -> DessertDetailViewModel {
    let viewModel = DessertDetailViewModel(id: "")
    viewModel.mealDetails = MealDetails(
      id: "52767",
      name: "Bakewell tart",
      thumbnailURL: "",
      instructions: "To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.\r\nRoll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 (180C fan).\r\nLine the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.\r\nFor the filing, spread the base of the flan generously with raspberry jam.\r\nMelt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.\r\nBake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning."
    )
    return viewModel
  }
  static var previews: some View {
    DessertDetailView(viewModel: makePreviewViewModel())
      .environmentObject(MealServiceAPI())
  }
}
