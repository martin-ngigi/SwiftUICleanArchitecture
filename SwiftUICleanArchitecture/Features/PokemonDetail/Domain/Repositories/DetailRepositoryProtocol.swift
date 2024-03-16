//
//  DetailRepositoryProtocol.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

protocol DetailRepositoryProtocol{
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetailEntity?
}
