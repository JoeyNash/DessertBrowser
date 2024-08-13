//
//  Meals.swift
//  DessertBrowser
//
//  Created by Joseph Nash on 8/12/24.
//

import Foundation

/// Condensed meal information for list browsing
struct MealBase: Codable {
  let name: String
  let thumbnailURL: String
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case name = "strMeal"
    case thumbnailURL = "strMealThumb"
    case id = "idMeal"
  }
}

struct MealBaseResponse: Codable {
  let meals: [MealBase]
}

/// Detailed meal information for solo viewing
struct MealDetails: Codable {
  // Base details
  let id: String
  let name: String
  let thumbnailURL: String
  let drink: String?
  let category: String
  let originRegion: String
  let instructions: String
  let tags: String
  let youtubeURL: String
  let source: String?
  let imageSource: String?
  let creativeCommonsConfirmed: String?
  let dateModified: Date?
  // Ingredients
  let ingredient1: String?
  let ingredient2: String?
  let ingredient3: String?
  let ingredient4: String?
  let ingredient5: String?
  let ingredient6: String?
  let ingredient7: String?
  let ingredient8: String?
  let ingredient9: String?
  let ingredient10: String?
  let ingredient11: String?
  let ingredient12: String?
  let ingredient13: String?
  let ingredient14: String?
  let ingredient15: String?
  let ingredient16: String?
  let ingredient17: String?
  let ingredient18: String?
  let ingredient19: String?
  let ingredient20: String?
  // Measures
  let measure1: String?
  let measure2: String?
  let measure3: String?
  let measure4: String?
  let measure5: String?
  let measure6: String?
  let measure7: String?
  let measure8: String?
  let measure9: String?
  let measure10: String?
  let measure11: String?
  let measure12: String?
  let measure13: String?
  let measure14: String?
  let measure15: String?
  let measure16: String?
  let measure17: String?
  let measure18: String?
  let measure19: String?
  let measure20: String?

  /// Combination of non-nil/non-empty ingredients in array for parsing
  var ingredients: [String] {
    var ingredients: [String] = []
    if let ingredient1 = ingredient1,
       !ingredient1.isEmpty {
      ingredients.append(ingredient1)
    }
    if let ingredient2 = ingredient2,
       !ingredient2.isEmpty {
      ingredients.append(ingredient2)
    }
    if let ingredient3 = ingredient3,
       !ingredient3.isEmpty {
      ingredients.append(ingredient3)
    }
    if let ingredient4 = ingredient4,
       !ingredient4.isEmpty {
      ingredients.append(ingredient4)
    }
    if let ingredient5 = ingredient5,
       !ingredient5.isEmpty {
      ingredients.append(ingredient5)
    }
    if let ingredient6 = ingredient6,
       !ingredient6.isEmpty {
      ingredients.append(ingredient6)
    }
    if let ingredient7 = ingredient7,
       !ingredient7.isEmpty {
      ingredients.append(ingredient7)
    }
    if let ingredient8 = ingredient8,
       !ingredient8.isEmpty {
      ingredients.append(ingredient8)
    }
    if let ingredient9 = ingredient9,
       !ingredient9.isEmpty {
      ingredients.append(ingredient9)
    }
    if let ingredient10 = ingredient10,
       !ingredient10.isEmpty {
      ingredients.append(ingredient10)
    }
    if let ingredient11 = ingredient11,
       !ingredient11.isEmpty {
      ingredients.append(ingredient11)
    }
    if let ingredient12 = ingredient12,
       !ingredient12.isEmpty {
      ingredients.append(ingredient12)
    }
    if let ingredient13 = ingredient13,
       !ingredient13.isEmpty {
      ingredients.append(ingredient13)
    }
    if let ingredient14 = ingredient14,
       !ingredient14.isEmpty {
      ingredients.append(ingredient14)
    }
    if let ingredient15 = ingredient15,
       !ingredient15.isEmpty {
      ingredients.append(ingredient15)
    }
    if let ingredient16 = ingredient16,
       !ingredient16.isEmpty {
      ingredients.append(ingredient16)
    }
    if let ingredient17 = ingredient17,
       !ingredient17.isEmpty {
      ingredients.append(ingredient17)
    }
    if let ingredient18 = ingredient18,
       !ingredient18.isEmpty {
      ingredients.append(ingredient18)
    }
    if let ingredient19 = ingredient19,
       !ingredient19.isEmpty {
      ingredients.append(ingredient19)
    }
    if let ingredient20 = ingredient20,
       !ingredient20.isEmpty {
      ingredients.append(ingredient20)
    }
    return ingredients
  }

  /// Combination of non-nil/non-empty measures in array for parsing
  var measures: [String] {
    var measures: [String] = []
    if let measure1 = measure1,
       !measure1.isEmpty {
      measures.append(measure1)
    }
    if let measure2 = measure2,
       !measure2.isEmpty {
      measures.append(measure2)
    }
    if let measure3 = measure3,
       !measure3.isEmpty {
      measures.append(measure3)
    }
    if let measure4 = measure4,
       !measure4.isEmpty {
      measures.append(measure4)
    }
    if let measure5 = measure5,
       !measure5.isEmpty {
      measures.append(measure5)
    }
    if let measure6 = measure6,
       !measure6.isEmpty {
      measures.append(measure6)
    }
    if let measure7 = measure7,
       !measure7.isEmpty {
      measures.append(measure7)
    }
    if let measure8 = measure8,
       !measure8.isEmpty {
      measures.append(measure8)
    }
    if let measure9 = measure9,
       !measure9.isEmpty {
      measures.append(measure9)
    }
    if let measure10 = measure10,
       !measure10.isEmpty {
      measures.append(measure10)
    }
    if let measure11 = measure11,
       !measure11.isEmpty {
      measures.append(measure11)
    }
    if let measure12 = measure12,
       !measure12.isEmpty {
      measures.append(measure12)
    }
    if let measure13 = measure13,
       !measure13.isEmpty {
      measures.append(measure13)
    }
    if let measure14 = measure14,
       !measure14.isEmpty {
      measures.append(measure14)
    }
    if let measure15 = measure15,
       !measure15.isEmpty {
      measures.append(measure15)
    }
    if let measure16 = measure16,
       !measure16.isEmpty {
      measures.append(measure16)
    }
    if let measure17 = measure17,
       !measure17.isEmpty {
      measures.append(measure17)
    }
    if let measure18 = measure18,
       !measure18.isEmpty {
      measures.append(measure18)
    }
    if let measure19 = measure19,
       !measure19.isEmpty {
      measures.append(measure19)
    }
    if let measure20 = measure20,
       !measure20.isEmpty {
      measures.append(measure20)
    }
    return measures
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "strMeal"
    case thumbnailURL = "strMealThumb"
    case id = "idMeal"
    case drink = "strDrinkAlternate"
    case category = "strCategory"
    case originRegion = "strArea"
    case instructions = "strInstructions"
    case tags = "strTags"
    case youtubeURL = "strYoutube"
    case source = "strSource"
    case imageSource = "strImageSource"
    case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
    case dateModified
    
    case ingredient1 = "strIngredient1"
    case ingredient2 = "strIngredient2"
    case ingredient3 = "strIngredient3"
    case ingredient4 = "strIngredient4"
    case ingredient5 = "strIngredient5"
    case ingredient6 = "strIngredient6"
    case ingredient7 = "strIngredient7"
    case ingredient8 = "strIngredient8"
    case ingredient9 = "strIngredient9"
    case ingredient10 = "strIngredient10"
    case ingredient11 = "strIngredient11"
    case ingredient12 = "strIngredient12"
    case ingredient13 = "strIngredient13"
    case ingredient14 = "strIngredient14"
    case ingredient15 = "strIngredient15"
    case ingredient16 = "strIngredient16"
    case ingredient17 = "strIngredient17"
    case ingredient18 = "strIngredient18"
    case ingredient19 = "strIngredient19"
    case ingredient20 = "strIngredient20"
    
    case measure1 = "strMeasure1"
    case measure2 = "strMeasure2"
    case measure3 = "strMeasure3"
    case measure4 = "strMeasure4"
    case measure5 = "strMeasure5"
    case measure6 = "strMeasure6"
    case measure7 = "strMeasure7"
    case measure8 = "strMeasure8"
    case measure9 = "strMeasure9"
    case measure10 = "strMeasure10"
    case measure11 = "strMeasure11"
    case measure12 = "strMeasure12"
    case measure13 = "strMeasure13"
    case measure14 = "strMeasure14"
    case measure15 = "strMeasure15"
    case measure16 = "strMeasure16"
    case measure17 = "strMeasure17"
    case measure18 = "strMeasure18"
    case measure19 = "strMeasure19"
    case measure20 = "strMeasure20"
  }
}

struct MealDetailResponse: Codable {
  let meals: [MealDetails]
}
