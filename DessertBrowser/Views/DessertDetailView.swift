//
//  DessertDetailView.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/13/24.
//

import SwiftUI

struct DessertDetailView: View {
  @EnvironmentObject var service: MealServiceAPI
  let id: String
  @State var mealDetails: MealDetails = MealDetails(id: "", name: "", thumbnailURL: "", instructions: "")

  var body: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 12) {
        Text(mealDetails.name)
          .padding()
        AsyncImage(url: URL(string: mealDetails.thumbnailURL)) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          ProgressView()
            .progressViewStyle(.circular)
        }
        .frame(width: 200, height: 200)
        LazyVStack {
          ForEach(mealDetails.ingredientMeasuresStrings, id: \.self) { ingredient in
            Text(ingredient)
          }
        }
        Text(mealDetails.instructions)
          .padding()
      }
    }
    .task {
      Task {
        mealDetails = try await service.getDessertDetails(for: id)
      }
    }
  }
}

struct DessertDetailView_Previews: PreviewProvider {
  static var previews: some View {
    DessertDetailView(
      id: "52767",
      mealDetails: MealDetails(
        id: "52767",
        name: "Bakewell tart",
        thumbnailURL: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg",
        instructions: "To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.\r\nRoll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 (180C fan).\r\nLine the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.\r\nFor the filing, spread the base of the flan generously with raspberry jam.\r\nMelt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.\r\nBake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning."
      )
    )
  }
}
