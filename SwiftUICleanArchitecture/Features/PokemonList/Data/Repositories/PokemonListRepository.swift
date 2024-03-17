//
//  ExploreRepository.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

//class ExploreRepository: ExploreRespo

class PokemonListRepository: PokemonListRepositoryProtocol {
    
    static let shared = PokemonListRepository()
    
    private let exploreDataSource = PokemonListDataSource()
    
    
    func fetchPokemons(limit: Int, offset: Int) async -> Result<[PokemonEntity], APIError> {
        let pokemonListResponseResult = await exploreDataSource.fetchPokemons(limit: limit, offset: offset)
        
        switch pokemonListResponseResult {
            case .success(let pokemonListResponse):
                let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
                let pokemonEntities: [PokemonEntity] = pokemonResponse.map { pokemon in
                    return PokemonEntity(pokemonResponse: pokemon)!
                }
                return .success(pokemonEntities)
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity] {
            let pokemonListResponse: PokemonListResponseModel = try await exploreDataSource.fetchPokemons2(limit: limit, offset: offset)
            let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
            let pokemonEntities: [PokemonEntity] = pokemonResponse.compactMap { pokemon in
                return PokemonEntity(pokemonResponse: pokemon)
            }
            return pokemonEntities
    }
    
//    
//    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity] {
//        let pokemonListResponse: PokemonListResponseModel = try await exploreDataSource.fetchPokemons2(limit: limit, offset: offset)
//        let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
//        let pokemonEntities: [PokemonEntity] = pokemonResponse.compactMap { pokemon in
//            return PokemonEntity(pokemonResponse: pokemon)
//        }
//        return pokemonEntities
//    }
    
}
