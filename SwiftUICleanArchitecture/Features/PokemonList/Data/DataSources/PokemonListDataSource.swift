//
//  ExploreDataSource.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class PokemonListDataSource{

    func fetchPokemons(limit: Int, offset: Int) async -> Result<PokemonListResponseModel, APIError> {
        guard let url = Constants.APIEndpoint.getPokemonList(limit: limit, offset: offset).url else {
            return .failure(APIError.badURL)
        }
        
        return await NetworkUtils.shared.fetch(type: PokemonListResponseModel.self, from: url)
    }
    
    
    func fetchPokemons2(limit: Int, offset: Int) async throws -> PokemonListResponseModel{
        guard let url: URL = Constants.APIEndpoint.getPokemonList(limit: limit, offset: offset).url else {
            throw URLError(.badURL)
        }
        return try await NetworkUtils.shared.fetch2(from: url)
    }

}
