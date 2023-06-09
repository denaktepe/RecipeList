//
//  DataService.swift
//  RecipeList
//
//  Created by Samet Cagri Aktepe on 29/03/2023.
//

import Foundation

class DataService {
    static func getLocalData() -> [Recipe] {
        // Parse local json file
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Check if pathString is not nill, otherwise...
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add the unique IDs
                for recipe in recipeData {
                    recipe.id = UUID()
                    
                    // Add unique IDs to recipe ingredients
                    for ingredient in recipe.ingredients {
                        ingredient.id = UUID()
                    }
                }
                
                // Return recipes
                return recipeData
            } catch {
                print(error)
            }
            
            
        }
        catch {
            // Error with geting data
            print(error)
        }
        
        return [Recipe]()
    }
}
