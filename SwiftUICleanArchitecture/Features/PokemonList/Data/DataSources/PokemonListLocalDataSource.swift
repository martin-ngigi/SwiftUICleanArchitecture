//
//  PokemonListLocalDataSource.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 19/03/2024.
//

import Foundation
import SwiftData

class PokemonListLocalDataSource {
    func createPokemon(pokemon: PokemonSwiftDTO, context: ModelContext) throws {
        do {
            try SwiftDataOperations(operationType: .create(pokemon, context)).performOperation()
        }
        catch {
            throw error
        }

    }
}
