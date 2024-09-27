//
//  IngredientView.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

import SwiftUI

struct IngredientView: View {
    let ingredients: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.CocktailDetails.ingredients)
                .font(.headline)
                .padding(.bottom, 4)
            
            ForEach(ingredients, id: \.self) { ingredient in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(.top, 8)
                    
                    Text("\(ingredient)")
                        .font(.body)
                }
            }
        }
        .padding(.vertical)
    }
}
