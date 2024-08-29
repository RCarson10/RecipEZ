//
//  RecipeService.swift
//  RecipEZ
//
//  Created by Gaj Carson on 1/6/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(searchText: String) async throws
    var recipes: [Recipe] {get set}
}
public class RecipeService: RecipeServiceProtocol {
    var recipes: [Recipe] = []

    func fetchRecipes(searchText: String = "") async throws {

        guard let url = URL(string:"https://food2fork.ca/api/recipe/search/?page=2&query=\(searchText)") else {
            throw RecipeError.urlCreationFailed
        }

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization": "Token 9c8b06d329136da358c2d00e76946b0111ce2c48"
        ]
        let (data, response) = try await session.data(for: request)

        Task {

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                throw RecipeError.requestFailed
            }

              guard let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
                throw RecipeError.responseDecodingFailed
            }
            recipes = recipeResponse.results
        }
    }
}
