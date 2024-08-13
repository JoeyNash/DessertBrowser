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
  func getMealThumbnail(from url: String, small: Bool) async throws -> UIImage
}

class MealServiceAPI: MealService {

  private static var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  private let host = "https://themealdb.com/api/json/v1/1/"

  // MARK: - Image Fetching Optimization
  private enum ImageLoadStatus {
    case inProgress(Task<UIImage, Error>)
    case success(UIImage)
  }

  private var requestCache: [String: ImageLoadStatus] = [:]

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
  
  func getMealThumbnail(from url: String, small: Bool) async throws -> UIImage {
    // Check if we already have the image, or an in-progress request.
    if let status = requestCache[url] {
      switch status {
        case .success(let image):
          // Image already fetched. Return it
          return image
        case .inProgress(let task):
          // Task in progress. Either return successful image or throw error
          return try await task.value
      }
    }

    // Build and run the request
    guard let requestURL = URL(string: url) else {
      throw(NSError(domain: "Bad URL", code: -1))
    }
    let request = URLRequest(url: requestURL)
    // Create task to store. Will cache task to prevent duplicate requests
    let task: Task<UIImage, Error> = Task {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard (response as? HTTPURLResponse)?.statusCode == 200,
            let image = UIImage(data: data) else {
        throw(NSError(domain: "Invalid Response", code: -3))
      }
      return image
    }
    // Set request cache so future requests to same image will wait on it with above code
    requestCache[url] = .inProgress(task)
    let image = try await task.value
    // if success, set cache to return image right away
    requestCache[url] = .success(image)
    return image
  }
}
