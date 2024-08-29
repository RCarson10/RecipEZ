//
//  Recipe.swift
//  RecipEZ
//
//  Created by Gaj Carson on 12/12/23.
//

import Foundation
import SwiftData

// MARK: Media Response
public struct RecipeResponse: Codable {
  // MARK: Properties
  var results: [Recipe]
}

// MARK: Coding Keys
enum CodingKeys: String, CodingKey {
  case id
  case pk
  case title
  case publisher
  case featured_image
  case rating
  case source_url
  case description
  case cooking_instructions
  case ingredients
  case date_added
  case date_updated
  case long_date_added
  case long_date_updated
}

@Model
class Recipe: Codable, Hashable {
    var id = UUID()
    var pk: Int
    var title: String
    var publisher: String
    var featured_image: String
    var rating: Int
    var source_url: String
    var recipe_description: String
    var cooking_instructions: String?
    var ingredients: [String]
    var date_added: String
    var date_updated: String
    var long_date_added: Int
    var long_date_updated: Int

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        pk = try container.decode(Int.self, forKey: .pk)
        title = try container.decode(String.self, forKey: .title)
        publisher = try container.decode(String.self, forKey: .publisher)
        featured_image = try container.decode(String.self, forKey: .featured_image)
        rating = try container.decode(Int.self, forKey: .rating)
        source_url = try container.decode(String.self, forKey: .source_url)
        recipe_description = try container.decode(String.self, forKey: .description)
        cooking_instructions = try container.decode(String.self, forKey: .cooking_instructions)
        ingredients = try container.decode([String].self, forKey: .ingredients)
        date_added = try container.decode(String.self, forKey: .date_added)
        date_updated = try container.decode(String.self, forKey: .date_updated)
        long_date_added = try container.decode(Int.self, forKey: .long_date_added)
        long_date_updated = try container.decode(Int.self, forKey: .long_date_updated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(pk, forKey: .pk)
        try container.encode(title, forKey: .title)
        try container.encode(publisher, forKey: .publisher)
        try container.encode(featured_image, forKey: .featured_image)
        try container.encode(rating, forKey: .rating)
        try container.encode(source_url, forKey: .source_url)
        try container.encode(recipe_description, forKey: .description)
        try container.encode(cooking_instructions, forKey: .cooking_instructions)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(date_added, forKey: .date_added)
        try container.encode(date_updated, forKey: .date_updated)
        try container.encode(long_date_added, forKey: .long_date_added)
        try container.encode(long_date_updated, forKey: .long_date_updated)
    }

}
