//
//  ExploreDataSource.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class ExploreDataSource{
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponseModel{
        guard let url: URL = Constants.APIEndpoint.getPokemonList(limit: limit, offset: offset).url else {
            throw URLError(.badURL)
        }
        return try await NetworkUtils.shared.fetch(from: url)
    }
}
