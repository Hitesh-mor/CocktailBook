//
//  CocktailDetailView.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

import SwiftUI

struct CocktailDetailView: View {
    
    @ObservedObject var viewModel: CocktailDetailViewModel
    @State var isFavioute: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Image(viewModel.cocktail.imageName)
                    .resizable()
                    .frame(height: 200)
                
                Text(viewModel.cocktail.longDescription)
                    .padding(.horizontal, 15)
                    .font(.body)
                
                IngredientView(ingredients: viewModel.cocktail.ingredients)
                    .padding(.horizontal, 10)

                Spacer()
            }
            .navigationTitle(viewModel.cocktail.name)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFavioute = viewModel.isFavoritesCocktail()
            }
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isFavioute = self.viewModel.toggleFavorites()
                    }) {
                        Image(systemName: isFavioute ? Constants.Image.heartFill : Constants.Image.heart)
                            .foregroundColor(.purple)
                    }
                }
            }
            .padding([.horizontal, .top], 8)
        }
    }
}
