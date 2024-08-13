//
//  MealService.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/13/24.
//

import UIKit

protocol MealService {
  func getDessertList() async throws -> [MealBase]
  func getDessertDetails(for id: String) async throws -> MealDetails
}

class MealServiceAPI: MealService {

  private static var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  private let host = "https://themealdb.com/api/json/v1/1/"

  // MARK: - Fetching Functions
  func getDessertList() async throws -> [MealBase] {
    guard let requestURL = URL(string: host+"filter.php?c=Dessert") else {
      throw(NSError(domain: "Bad URL", code: -1))
    }

    let request = URLRequest(url: requestURL)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200,
          let mealResponse = try? Self.decoder.decode(MealBaseResponse.self, from: data) else {
      throw(NSError(domain: "Invalid Response", code: -3))
    }
    return mealResponse.meals
  }
  
  func getDessertDetails(for id: String) async throws -> MealDetails {
    guard let requestURL = URL(string: host+"lookup.php?i=\(id)") else {
      throw(NSError(domain: "Bad URL", code: -1))
    }

    let request = URLRequest(url: requestURL)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200,
          let mealResponse = try? Self.decoder.decode(MealDetailResponse.self, from: data),
          let meal = mealResponse.meals.first else {
      throw(NSError(domain: "Invalid Response", code: -3))
    }
    return meal
  }
}
