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
    
    // Function to check if there is an existing Pokémon with a specified name
    func checkExistingPokemon(withName name: String, in pokemonList: [PokemonSwiftDTO]) -> Bool {
        for pokemon in pokemonList {
            if pokemon.name.lowercased() == name.lowercased() {
                return true // Found a Pokémon with the specified name
            }
        }
        return false // No Pokémon found with the specified name
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
