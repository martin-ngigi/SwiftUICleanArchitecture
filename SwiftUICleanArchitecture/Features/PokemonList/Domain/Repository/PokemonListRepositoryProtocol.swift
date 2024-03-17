//
//  ExploreRepositoryProtocol.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

protocol PokemonListRepositoryProtocol{
    func fetchPokemons(limit: Int, offset: Int) async -> Result<[PokemonEntity], APIError>
    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity]
}
