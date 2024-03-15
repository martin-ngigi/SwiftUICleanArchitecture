//
//  ExploreRepository.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

//class ExploreRepository: ExploreRespo

class ExploreRepository: ExploreRepositoryProtocol {
    static let shared = ExploreRepository()
    
    private let exploreDataSource = ExploreDataSource()
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> [PokemonEntity] {
        let pokemonListResponse: PokemonListResponseModel = try await exploreDataSource.fetchPokemons(limit: limit, offset: offset)
        let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
        let pokemonEntities: [PokemonEntity] = pokemonResponse.compactMap { pokemon in
            return PokemonEntity(pokemonResponse: pokemon)
        }
        return pokemonEntities
    }
}
