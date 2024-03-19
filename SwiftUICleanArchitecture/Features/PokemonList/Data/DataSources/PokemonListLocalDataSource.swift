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
    
    func deletePokemon(pokemon: PokemonSwiftDTO, context: ModelContext) throws {
        do {
            let _ = try SwiftDataOperations(operationType: .delete(pokemon, context)).performOperation()
        }
        catch {
            throw error
        }

    }
    
    func getPokemonList(fetchDescriptor: FetchDescriptor<PokemonSwiftDTO>, context: ModelContext) throws -> [PokemonSwiftDTO] {
        var pokemonList: [PokemonSwiftDTO] = []
        do {
            pokemonList = try SwiftDataOperations(operationType: .readList(fetchDescriptor, context)).performOperation()
        }
        catch {
            pokemonList = []
            throw error
        }
        return pokemonList
    }
}
