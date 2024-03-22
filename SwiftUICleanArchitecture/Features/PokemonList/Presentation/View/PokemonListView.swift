//
//  PokemonExploreView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI
import SwiftData

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonListViewModel()
    @Environment(\.modelContext) var context
    @ObservedObject var networkInfo = NetworkInfoImpl()

    var body: some View {
        NavigationStack{
                        
            List{
                if !networkInfo.isConnected {
                    NetworkStatusView()
                }
                
                ForEach(viewModel.pokemonList, id: \.self){ pokemon in
                    NavigationLink(destination: PokemonDetailView(id: pokemon.id)) {
                        PokemonRowView(pokemon: pokemon, networkInfo: networkInfo)
                            .onAppear{
                                if viewModel.pokemonList.last == pokemon {
                                    Task { await viewModel.loadMore(modelContext: context, isInternetConnected: networkInfo.isConnected) }
                                }
                            }
                    }
                }
                
                // handel states and loading as well
                ListPlaceholderRowView(modelContext: context, isInternetConnected: networkInfo.isConnected, state: viewModel.state, loadMore: viewModel.loadMore)


            }
            .navigationTitle("Pokemons")
            .task { //loadMore() on appear
                await viewModel.loadMore(modelContext: context, isInternetConnected: networkInfo.isConnected )
            }
            .refreshable { // loadMore() when pull to refreshed
                await viewModel.loadMore(modelContext: context, isInternetConnected: networkInfo.isConnected )
            }
            .toolbar {
    //             Refresh
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        Task{
                            await viewModel.loadMore(modelContext: context, isInternetConnected: networkInfo.isConnected )
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
//                        Text("Refresh")
                    }
                    .buttonStyle(.bordered)
                }
                    
            }
            
            /// For loading more
//            if viewModel.state == .isLoading{
//                LoadingIndicatorView()
//            }
        }
    }
        
    
    
}

#Preview {
   PokemonListView()
}
