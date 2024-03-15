//
//  DetailRepository.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
class DetailRepository: DetailRepositoryProtocol{
    static let shared = DetailRepository()
    
    private let detailDataSource = DetailDataSource()
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetailEntity? {
        let pokemonDetailResponse: PokemonDetailResponseModel = try await detailDataSource.fetchPokemonDatail(id: id)
        guard let pokemonDetail: PokemonDetailEntity = PokemonDetailEntity(pokemonDetailResponse: pokemonDetailResponse) else {
            return nil
        }
        return pokemonDetail
    }
}
