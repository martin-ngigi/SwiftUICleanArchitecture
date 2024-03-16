//
//  PokemonExploreView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.pokemonList, id: \.self){ pokemon in
                    NavigationLink(destination: PokemonDetailView(id: pokemon.id)) {
                        PokemonRowView(pokemon: pokemon)
                            .onAppear{
                                if viewModel.pokemonList.last == pokemon {
                                    Task { await viewModel.loadMore() }
                                }
                            }
                    }
                }
                
                // handel states and loading as well
                ListPlaceholderRowView(state: viewModel.state, loadMore: viewModel.loadMore)
            }
            .navigationTitle("Pokemons")
            
            /// For loading more
//            if viewModel.state == .isLoading{
//                LoadingIndicatorView()
//            }
        }
    }
        
    
    var body2: some View {
        NavigationStack{
            if viewModel.state == .isLoading{
                LoadingIndicatorView()
            }
            else if viewModel.state == .noResults{
                ContentUnavailableView("No pokemons", systemImage: "tray.full")
            }
            
            else if viewModel.pokemonList.count > 0 {
                List{
                    ForEach(viewModel.pokemonList, id: \.self){ pokemon in
                        NavigationLink(destination: PokemonDetailView(id: pokemon.id)) {
                            PokemonRowView(pokemon: pokemon)
                                .onAppear{
                                    if viewModel.pokemonList.last == pokemon {
                                        Task { await viewModel.loadMore() }
                                    }
                                }
                        }
                    }
                    
                }
                .navigationTitle("Pokemons")
            }
        }
//        .task { //loadMore() on appear
//            await viewModel.loadMore()
//        }
        
    }
    
}

#Preview {
   PokemonListView()
}
