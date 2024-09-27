//
//  CocktailListView.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//
import SwiftUI

struct CocktailListView: View {
    @ObservedObject var viewModel: CocktailViewModel
    @EnvironmentObject var coordinator: CocktailCoordinator
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                        .padding()
                } else {
                    Picker(Constants.Segments.filter, selection: $viewModel.filter) {
                        Text(Constants.Segments.all).tag(CocktailFilter.all)
                        Text(Constants.Segments.alcoholic).tag(CocktailFilter.alcoholic)
                        Text(Constants.Segments.nonAlcoholic).tag(CocktailFilter.nonAlcoholic)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: viewModel.filter) { _ in
                        viewModel.loadCocktails()
                    }
                    
                    
                    List {
                        ForEach(viewModel.filteredCocktails, id: \.id) { cocktail in
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(cocktail.name)
                                        .foregroundColor(viewModel.favorites.isFavorite(cocktail: cocktail) ? .purple : .black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: viewModel.favorites.isFavorite(cocktail: cocktail) ? Constants.Image.heartFill : Constants.Image.heart)
                                        .foregroundColor(.purple)
                                }
                                Spacer()
                                    .frame(height: 10)
                                Text(cocktail.shortDescription)
                            }.onTapGesture {
                                coordinator.showCocktailDetail(cocktail)
                            }

                        }
                    }
                    .listStyle(PlainListStyle())


//                    Rectangle()
//                        .size(CGSize(width: 25, height: 25))
//                        .foregroundColor(Color(UIColor(.blue)))
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(viewModel.getNavigationTitle())
                        .bold()
                        .font(.system(size: 32))
                }
            })
            .onAppear {
                viewModel.loadCocktails()
            }
        }
    }
}
