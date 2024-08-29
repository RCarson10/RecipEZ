//
//  ContentView.swift
//  RecipEZ
//
//  Created by Gaj Carson on 12/4/23.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    
    @ObservedObject private var vm = RecipeViewModel()
    @State private var searchText = ""
    @Environment(\.openURL) var openURL
    
    var body: some View {
        @State var recipes = vm.recipes
        
        NavigationStack {
            List {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink {
                       @State var ingredients = recipe.ingredients
                        Form {
                            Section(content: {
                                Text(recipe.recipe_description)
                            }, header: {
                                Text("Description of the recipe")
                                    .font(.system(size: 16, weight: .bold))
                            })
                            Section(content: {
                                Text(recipe.cooking_instructions ?? "No Instructions available")
                            }, header: {
                                Text("Instructions")
                                    .font(.system(size: 16, weight: .bold))
                            })
                            Section(content: {
                                List(recipe.ingredients,id: \.self) { ingredient in
                                    Text(ingredient)
                                }
                            }, header: {
                                Text("Ingredients")
                                    .font(.system(size: 16, weight: .bold))
                            })
                            Section(content: {
                                Button("Source", action: {
                                    openURL(URL(string: recipe.source_url)!)
                                })
                                .padding()
                                .background(Color.orange)
                                .clipShape(Capsule())
                            }, header: {
                                Text("Link to full recipe")
                                    .font(.system(size: 16, weight: .bold))
                            })
                            Section(content: {
                                AsyncImage(url: URL(string: recipe.featured_image))
                            }, header: {
                                Text("Image")
                                    .font(.system(size: 16, weight: .bold))
                            })
                        }
                        .navigationTitle(recipe.title)
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text(recipe.title)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(
                Text("RecipEZ")
            )
            .searchable(text: $searchText, prompt: "Enter some ingredients")
            .onChange(of: searchText) {
                Task {
                    try await vm.fetchRecipes(searchText: searchText)
                }
            }
        }
    }
}

#Preview {
    RecipeView()
}
