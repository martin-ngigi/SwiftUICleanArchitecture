//
//  PokemonExploreView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonListView: View {
    
    let getPokemonListUseCase: GetPokemonListUseCase = GetPokemonListUseCase(pokeRespository: ExploreRepository.shared)
    
    @State private var pokemonList: [PokemonEntity] = []
    @State private var offset: Int = 0
    let limit: Int = 20
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(pokemonList, id: \.self){ pokemon in
                    NavigationLink(destination: PokemonDetailView(id: pokemon.id)) {
                        PokemonRowView(pokemon: pokemon)
                            .onAppear{
                                if pokemonList.last == pokemon {
                                    Task { await loadMore() }
                                }
                            }
                    }
                }
            }
        }
        .task {
            await loadMore()
        }
        .navigationTitle("Pokemons")
    }
    
    func loadMore() async {
        do{
            let newPokemonList = try await getPokemonListUseCase.execute(limit: limit, offset: offset)
            pokemonList += newPokemonList
            offset += newPokemonList.count
        }
        catch{
            print("loadMore Error occurred: \(error.localizedDescription)")
        }
    }
}

#Preview {
   PokemonListView()
}
