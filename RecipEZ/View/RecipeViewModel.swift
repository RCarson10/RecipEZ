//
//  RecipeViewModel.swift
//  RecipEZ
//
//  Created by Gaj Carson on 1/6/24.
//

import SwiftUI

public enum RecipeError: Error {
    case requestFailed
    case responseDecodingFailed
    case urlCreationFailed
}

public class RecipeViewModel: ObservableObject {
    // MARK: Properties
    @Published var recipes: [Recipe] = []
    private var recipeService: RecipeServiceProtocol

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
    }

    func fetchRecipes(searchText: String = "") async throws {
        try await recipeService.fetchRecipes(searchText: searchText)
        await MainActor.run {
            recipes = recipeService.recipes
        }
    }
}
