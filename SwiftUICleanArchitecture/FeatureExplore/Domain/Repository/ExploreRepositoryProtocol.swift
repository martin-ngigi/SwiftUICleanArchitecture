//
//  ExploreRepositoryProtocol.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

protocol ExploreRepositoryProtocol{
    func fetchPokemons(limit: Int, offset: Int) async throws -> [PokemonEntity]
}
